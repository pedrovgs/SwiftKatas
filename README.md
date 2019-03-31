# <img alt="Swift" src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/9d/Swift_logo.svg/2000px-Swift_logo.svg.png" height="60"/> <img alt="Bow" src="https://avatars2.githubusercontent.com/u/44965417?s=200&v=4" height="50"/> SwiftKatas [![Build Status](https://travis-ci.com/pedrovgs/SwiftKatas.svg?branch=master)](https://travis-ci.com/pedrovgs/SwiftKatas)

Swift training repository used to learn Swift and Functional Programming by solving some common katas using just purely functional programming with [Bow](https://github.com/bow-swift/bow). This project uses CocoaPods, remember to execute ``pod install`` before start using this repository for any development purpose.

### List of katas:

| # | Kata Statement | Topic |
|---|----------------|--------|
| 1 | [Maxibons](https://github.com/Karumi/MaxibonKataJava#-kata-maxibon-for-java-) | [https://github.com/Karumi/SwiftKatas/pull/1](https://github.com/Karumi/SwiftKatas/pull/1) | Polymorphic programming |
| 2 | [Form validation](https://gist.github.com/pedrovgs/d83fe1f096928715a6f31946e557995a) | [https://github.com/Karumi/SwiftKatas/pull/3](https://github.com/Karumi/SwiftKatas/pull/2) | Validated data type |

### Executing tests:

This project contains some tests written using XCTest and [SwiftCheck](https://github.com/typelift/SwiftCheck). You can easily run the tests by executing any of the following commands:

```
fastlane test
```

### Checkstyle:

For the project checkstyle we are using [SwfitLint](https://github.com/realm/SwiftLint). The code format will be evaluated after accepting any contribution to this repository using this tool. You can evaluate the state of the project using SwiftLint by running this command:

```
Pods/SwiftLint/swiftlint
```

If you need to automatically fix the linting error  you can run:

```
Pods/SwiftLint/swiftlint autocorrect
```

Developed By
------------

* Pedro Vicente Gómez Sánchez - <pedrovicente.gomez@gmail.com>

<a href="https://twitter.com/pedro_g_s">
  <img alt="Follow me on Twitter" src="https://image.freepik.com/iconos-gratis/twitter-logo_318-40209.jpg" height="60" width="60"/>
</a>
<a href="https://es.linkedin.com/in/pedrovgs">
  <img alt="Add me to Linkedin" src="https://image.freepik.com/iconos-gratis/boton-del-logotipo-linkedin_318-84979.png" height="60" width="60"/>
</a>

License
-------

    Copyright 2019 Pedro Vicente Gómez Sánchez

    Licensed under the GNU General Public License, Version 3 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.gnu.org/licenses/gpl-3.0.en.html

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
