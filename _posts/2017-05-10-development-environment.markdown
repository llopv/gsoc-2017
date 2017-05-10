---
layout: post
title:  "Setting up our environment"
date:   2017-05-10 14:16:03 +0200
categories: ide setup
---

We begin by downloading the code of WIAB (Wave in a Box). [Apache Wave
documetnation][1] tells us to download it using git:

```sh
$ git clone https://git-wip-us.apache.org/repos/asf/incubator-wave.git
```

We download the latest version of _Eclipse IDE for Java Developers_ from its
[download page][2]. It already includes the gradle plugin we need to import the
project.

To import the gradle project, we use _File > Import... > Gradle > Gradle
Project_. We select the folder where we downloaded `incubator-wave`, and we use
the default options. Once imported we should see three folders in the Package
Explorer: `incubator-wave` (root directory), `pst` (a dependency), and `wave`
(the code).

![Path build]({{ site.url }}/assets/ide-0.png)

Now, we may want to disable the option _Project > Build automatically_.

Right-clicking on `wave-incubator` folder, and then _Build Path > Configure
Build Path..._, we should add the following folders in the different tabs:

![Path build]({{ site.url }}/assets/ide-1.png)

![Path build]({{ site.url }}/assets/ide-2.png)

![Path build]({{ site.url }}/assets/ide-3.png)

![Path build]({{ site.url }}/assets/ide-4.png)

Now we can check everything is working with _Project > Build Project_.


[1]: https://incubator.apache.org/wave/source-code.html
[2]: https://www.eclipse.org/downloads/eclipse-packages/
