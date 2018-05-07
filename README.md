# How to let Obj-C test code use Swift app code?
*[Jeremy W. Sherman][author], 2018-05-07; using Xcode 9.3*

[author]: https://jeremywsherman.com/


## App code: Import App-Swift.h
To use Swift app code from Obj-C app code, you import the generated `-Swift.h` file.

- For an intro to how that works, see [my intro to Swift/Obj-C compilation][intro].
- For gory details, see [my detailed build log investigation][details], which is detailed enough to also have a [part 2][details-part2].

[intro]: https://www.bignerdranch.com/blog/manual-swift-understanding-the-swift-objective-c-build-pipeline/
[details]: https://www.bignerdranch.com/blog/build-log-groveling-for-fun-and-profit-manual-swift-continued/
[details-part2]: https://www.bignerdranch.com/blog/build-log-groveling-for-fun-and-profit-part-2-even-more-manual-swift/


## Test code: Can't find App-Swift.h to import it!
But try to do the same from your unit test code, and you'll run into an error like:

```
In file included from /Users/jeremy/Downloads/MixedLanguageTesting/MixedLanguageTestingTests/ObjCTests.m:10:

/Users/jeremy/Downloads/MixedLanguageTesting/MixedLanguageTesting/ObjCClassUsingSwiftClass.h:15:9:
fatal error: 'MixedLanguageTesting-Swift.h' file not found

#import "MixedLanguageTesting-Swift.h"
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        1 error generated.
```

This is the error that I wanted to fix.

If you just want the fix, you can [jump to the solution.][solution]

[solution]: #anchor-solution


## How NOT to do so: Compile the Swift code into your test target, too
You might run into this suggestion. It's not fun to set up after the fact, and
it'll double your build times.

That said, it will let you call that code.

But it won't let you call it as part of the app target; instead, you'll be
talking to it as part of the test target's compiled code.

And with the runtime name mangling, you might very well end up with two
identical but differently named classes, which can do fun things with any
category methods you're expecting to be around. (Not 100% on this - I never
seriously considered doing this, because I'd already run into issues doing the
"check ALL the targets" approach with plain old Obj-C code, never mind adding
Swift to the mix.)


## How to do so: Fix your header search paths!
The code you're trying to work with is loaded into your `TEST_HOST`.
You just need the interfaces declared by that generated header file to
rendez-vous with the code.

So that's precisely what you need to do: Stick the folder containing that
generated -Swift.h on your search path. That's how "file not found" errors with
header look-up are normally resolved; it's just extra annoying in this case,
because you wind up needing to work with another target's files, and Xcode
doesn't help much here.

You can look at where the file gets generated, and you'll see some hairy
path that boils down to "the derived sources dir for your app target".

### Solution for mixed-language test targets
If you've got a mixed-language test target, then your test target
will also have its own derived sources dir housing its own -Swift.h header,
and you can build the path to the app target's folder by backing up from
your own `DERIVED_SOURCES_DIR` and navigating down into the app target's:

```
HEADER_SEARCH_PATH = "$(DERIVED_SOURCES_DIR)/../../MixedLanguageTesting.build/DerivedSources"
```

This breaks if you don't actually ever `touch` your `DERIVED_SOURCES_DIR`,
though.

<a id="anchor-solution" />

### General Solution
The general solution is to build down to the path, rather than backing up:

```
HEADER_SEARCH_PATH = "$(CONFIGURATION_TEMP_DIR)/MixedLanguageTesting.build/DerivedSources"
```

Declare that at your project level (adjusting the app target name, of course),
and you should be good to go.

## How do you figure this out?
You can watch me stumble around and gradually figure this out by reviewing the history of
[this Git repository][git-repo]. (It took me round about 90 minutes.)

[git-repo]: https://github.com/jeremy-w/MixedLanguageTesting/commits/master
