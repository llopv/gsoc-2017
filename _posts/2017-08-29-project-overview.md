---
layout: post
title:  "GSoC 2016 Project Overview"
date:   2017-08-29 12:44:03 +0200
categories: code
---

*The code can be downloaded from [this git branch][code] (compare [changes][changes]).*

## Synopsis
[Apache Wave][wave] is a software framework for online real-time collaborative
edition. Similarly to Google Docs and Etherpad, it uses [Operational
Transformations][ot] to manage user collaboration.

During this Google Summer of Code we have provided end-to-end encryption to wave
documents. This means that only the people who know a particular key, have
access to the documents and can edit and retreive the contents of a them,
protecting in that way the privacy of Wave users.

We have based our work on [this awesome paper][paper] that explains how some
researchers encrypted Google Docs' Operational Transformations. We have took
their ideas and adapted them to Apache Wave's architecture.

## Produced work

To sumarize the work we have produced, we have recorded this video:

<div style="position:relative;height:0;padding-bottom:56.25%">
<iframe src="https://www.youtube-nocookie.com/embed/izPDptwDxwM?rel=0?ecver=2"
width="640" height="360" frameborder="0"
style="position:absolute;width:100%;height:100%;left:0" allowfullscreen>
</iframe></div>

<p></p>

To encrypt the messages we have used the algorithm AES-GCM from the WebCrypto
API. We have used JsInterop bindings to call it from our Java classes.

Messages are properly encrypted and decrypted when they are sent and received
by the clients. The texts of a documents are also properly recovered from the
server's snapshot. Everything seems to run smoothly, except for some annoying
bugs that appear sparsely, and a serious user interface bug that prevents users
that did not created the wave to decrypt its snapshot. My mentor and me think
that we can fix them quickly, just after the program has ended.

## How to use it

Running our modified version of Wave does not require any additional
configuration, just use Gradle commands as usual. To compile the code and
run the server use:

```sh
$ ./gradlew run
```

And open the url http://localhost:9898/ with any browser. Once registered and
logged in, use the "New Encrypted Wave" button to create a new encrypted wave.

![Encrypted Wave button]({{ site.github.url }}/assets/img/over-1.png)

In its URL you can see that the new wave's identifier starts with "ew+" instead
of "w+", as it is usual in common waves. Also, a symmetric cryptographic key is
attached, after the wave identifier, separated by an exclamation mark (!).

![Encrypted Wave URL]({{ site.github.url }}/assets/img/over-2.png)

The user must preserve that URL (or at least the key part) in order to open the
wave again in the future.

## Future work

AES-GCM assures both confidentiality and integrity for the messages written by
the legitimate users, but an attacker who has the control over the server can
still do a lot of harm:

* Only the text of a document is encrypted, but not other parts like the content
of its hiperlinks, for example. We should extend the encryption beyond the
inserted characters.
* The authentication could also be extended to all the components, not only text
ones. Also, as the [paper][paper] states that the history of a document should
also be authenticaded (see appendix A.2).
* It is unlikely to hide the structure and format of the document to the server,
but we may be able to hide some more information, like user's typing traits.

On the other hand, it is not convenient having users handling symmetric keys by
themselves. Keys should be encrypted and stored in the server as user data. To
do so, we should derive a key from the user's password using `pbkdf2` (available
in the WebCrypto API), to encrypt all the keys a user generates or registers
for her waves.

The users could use public key cryptograpy in order to being able to invite each
other to edit in a wave document. This feature were part of the original plan of
work for this Summer, but we have had not enough time to develop this part.

## Relevant links
* [List of commits][code]
* [How can Apache Wave Operational Transformations be encrypted? (Part 1)][encrypt-ot-1]
* [How can Apache Wave Operational Transformations be encrypted? (Part 2)][encrypt-ot-2]
* [Project code walkthrough][walkthrough]


[wave]: https://en.wikipedia.org/wiki/Apache_Wave
[ot]: https://en.wikipedia.org/wiki/Operational_transformation
[paper]: http://www.tara.tcd.ie/bitstream/handle/2262/68179/paper.pdf;sequence=1
[code]: https://github.com/llopv/incubator-wave/tree/gsoc-2017
[encrypt-ot-1]: https://llopv.github.io/gsoc-2017/e2ee/2017/06/30/encrypt-ot-1.html
[encrypt-ot-2]: https://llopv.github.io/gsoc-2017/e2ee/2017/08/31/encrypt-ot-2.html
[walkthrough]: https://llopv.github.io/gsoc-2017/code/2017/08/31/code-walkthrough.html
[changes]: https://github.com/llopv/incubator-wave/compare/800fbc87a0a0d1...gsoc-2017
