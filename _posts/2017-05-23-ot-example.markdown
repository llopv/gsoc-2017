---
layout: post
title:  "Operational Transformation example"
date:   2017-05-23 23:40:03 +0200
categories: ot
---

In this article, we use the last example of [Code Commit's blog post][1] in order to clarify it with specific operations.

![Path build]({{ site.github.url }}/assets/img/ot.png)

Client and Server initial revision is 0, and the document state is empty.

Client perspective:

* Alice types "Wave".
* Client sends _InsertText "Wave" @1, rev 0._ **(a)**. Document state = "Wave".
* Alice types "!".
* Client holds _InsertText "!" @5, rev 1._ **(b)**. Document state = "Wave!".
* Client receives _InsertText "World" @1, rev 0._ **(c)**
* Client applies _InsertText "World" @1, rev 2._ **(c')**. Document state = "WorldWave!
* Alice deletes "World".
* Client applies _DeleteText "World" @1, rev 3._ **(e)**. Document state = "Wave!"
* Client holds _InsertText "!" @5;DeleteText "World" @1, rev 4_. **((e*b')')**
* Client receives _InsertText "Hello " @1, rev 1._ **(d)**.
* Client applies _InsertText "Hello " @1, rev 4._ **(d')**. Document state = "Hello Wave!".
* Client receives ACK _InsertText "Wave" @12, rev 2._ **(a')**.
* Client sends _InsertText "!" @5;DeleteText "World" @1, rev 4_. **((e*b')')**

Server perspective:

* Bob sends _InsertText "World" @1, rev 0._ **(c)**
* Server applies it as it is. Revision = 1. Document state = "World".
* Bob sends _InsertText "Hello " @1, rev 1._ **(d)**
* Server applies it as it is. Revision = 2. Document state = "Hello World".
* Alice sends _InsertText "Wave" @1, rev 0._ **(a)**
* Server applies _InsertText "Wave" @12, rev 2._ **(a')**. Revision = 3. Document State = "Hello WorldWave".
* Server receives _InsertText "!"; DeleteText "World", rev ?_ **((e*b')')**
* Server applies it as it is. Revision = 4. Document State = "Hello Wave!"

Delta operations:

* **(a)**: InsertText "Wave" @1, `InsertCharacters('Wave');`
* **(b)**: InsertText "!" @1, `InsertCharacters('!');`
* **(c)**: InsertText "World" @1, `InsertCharacters('World');`
* **(d)**: InsertText "Hello " @1, `InsertCharacters('Hello ');`
* **(e)**: DeleteText "World" @1, `DeleteCharacters('World');`

[1]: http://www.codecommit.com/blog/java/understanding-and-applying-operational-transformation
