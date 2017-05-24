---
layout: post
title:  "Example on Operational Transformations"
date:   2017-05-23 23:40:03 +0200
categories: ot
---

In this article, we use the last example of [Code Commit's blog post][1] in order to clarify it with specific operations.

![Path build]({{ site.github.url }}/assets/img/ot.png)

Client and Server initial revision is 0, and the document state is empty.

## Client perspective

* Alice types "Wave".
* Client sends _InsertCharacters("Wave");_, rev 0. **(a)**. Document state = "Wave".
* Alice types "!".
* Client holds _retain(4); InsertCharacters("!!");_, rev 1. **(b)**. Document state = "Wave!!".
* Client receives _InsertCharacters("World");_, rev 0. **(c)**
* Client applies _InsertCharacters("World"); retain(6);_, rev 2. **(c')**. Document state = "WorldWave!!
* Alice deletes "World".
* Client applies _DeleteCharacters("World"); retain(6)_ , rev 3. **(e)**. Document state = "Wave!!"
* Client holds _DeleteCharacters("World"); retain(4); InsertCharacters("!!");_, rev 4. **((e⦁b')')**
* Client receives _InsertCharacters("Hello "); retain(5);_, rev 1. **(d)**.
* Client applies _InsertCharacters("Hello "); retain(6);_, rev 4. **(d')**. Document state = "Hello Wave!!".
* Client receives ACK _InsertCharacters("Wave");_, rev 2. **(a')**.
* Client sends _DeleteCharacters("World"); retain(4); InsertCharacters("!!");_, rev 4. **(e⦁b')**

## Server perspective

* Bob sends _InsertCharacters("World");_, rev 0. **(c)**
* Server applies it as it is. History = [c]. Document state = "World".
* Bob sends _InsertCharacters("Hello "); retain(5);_, rev 1. **(d)**
* Server applies it as it is. History = [c, d]. Document state = "Hello World".
* Alice sends _InsertCharacters("Wave");_, rev 0. **(a)**
* Server applies _retain(12); InsertCharacters("Wave");_, rev 2. **(a')**. History = [c, d, a']. Document State = "Hello WorldWave".
* Server receives _DeleteCharacters("World"); retain(4); InsertCharacters("!!");_, rev 4. **(e⦁b')**
* Server applies _retain(6); DeleteCharacters("World"); retain(4); InsertCharacters("!!");_, rev 4. **((e⦁b')')**. History = [c, d, a', (e⦁b')']. Document State = "Hello Wave!!"

[1]: http://www.codecommit.com/blog/java/understanding-and-applying-operational-transformation
