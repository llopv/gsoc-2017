---
layout: page
title: Project abstract
permalink: /abstract/
---

End-to-end encryption (E2EE) has been gaining relevance during the last years due to the increasing privacy concerns of users. Encrypting communications between the client and the server using SSL is not enough to protect users privacy, since data can be read in plaintext in the server, which is not trustworthy.

It is trickier to perform E2EE into SwellRT documents than it is to perform it into simple chat messages. SwellRT use operational transformations (OTs) to coordinate the insertion and deletion of characters in its documents, so instead of encrypting the entire document, we need to encrypt each operation and still guarantee that the server has enough information to coordinate the document editioning. Fortunately, it is a field that has been researched for many years and we have some studies that have successfully implemented E2EE in Google Docs. We can take their insights to encrypt SwellRT OTs.

The project has two parts. First, we need to encrypt and decrypt successfully SwellRT OTs, using a symmetric key. Then, we need to communicate those symmetric keys among users, and here is where we need public key cryptography.
