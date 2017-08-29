---
layout: post
title:  "GSoC 2016 Project Overview"
date:   2017-08-29 12:44:03 +0200
categories: code
---

<center>*The code can be downloaded from [this git branch][code].*</center>

## Synopsis
[Apache Wave][wave] is a software framework for online real-time collaborative
edition. Similarly to Google Docs and Etherpad, it uses [Operational
Transformations][ot] to manage user collaboration. During this Google Summer of
Code we are providing end-to-end encryption to wave documents. This means that
only the people with access to the documents (those who have shared a symmetric
key) can edit and retreive the contents of a document, protecting in that way
the privacy of wave users.

We base our GSOC work in [this awesome paper][paper] that explains how some
researchers encrypted Google Docs' Operational Transformations.

## Produced work

<div style="position:relative;height:0;padding-bottom:56.25%">
<iframe src="https://www.youtube-nocookie.com/embed/izPDptwDxwM?rel=0?ecver=2"
width="640" height="360" frameborder="0"
style="position:absolute;width:100%;height:100%;left:0" allowfullscreen>
</iframe></div>


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



### Temporary solution to decrypt waves
<a href="javascript:(function(){let alg={name:'AES-GCM',length:256};let keyUsages=['encrypt','decrypt'];function base64ToBuffer(base64){let binary_string=window.atob(base64);let len=binary_string.length;let bytes=new Uint8Array(len);for(var i=0;i<len;i+=1){bytes[i]=binary_string.charCodeAt(i)}return bytes.buffer}let getCryptoKey=(key)=>{let keydata={kty:'oct',k:key,alg:'A256GCM',ext:true};return window.crypto.subtle.importKey('jwk',keydata,alg,false,keyUsages)}let decrypt=(key,msg)=>{msg=msg.split(';');let iv=base64ToBuffer(msg[0]);let data=base64ToBuffer(msg[1]);let additionalData=base64ToBuffer(msg[2]);let params={name:'AES-GCM',iv,additionalData};return window.crypto.subtle.decrypt(params,key,data).then(buffer=>{return new TextDecoder('utf8').decode(buffer)})}let onServerResponse=(json)=>{console.log(json);let texts={};getCryptoKey(key).then(k=>{key=k;Promise.all(Object.keys(json.snapshots[0].ciphertexts).map((c)=>{return decrypt(key,json.snapshots[0].ciphertexts[c]).then(t=>texts[c]=t)})).then(()=>{console.log(texts);let content='';let pieces=json.snapshots[0].pieces;console.log(pieces);for(let k of Object.keys(pieces)){console.log(JSON.stringify(pieces[k]));console.log(texts[pieces[k].rev].substring(pieces[k].offset,pieces[k].offset+pieces[k].len));content+=texts[pieces[k].rev].substring(pieces[k].offset,pieces[k].offset+pieces[k].len)}let i=0;document.querySelector('.document').innerHTML=document.querySelector('.document').innerHTML.split('').map(c=>{if(c=='*'/***/){return content.charAt(i++)}else{return c}}).join('')})})}let waveletId=location.hash.substr(1).split('!')[0];let key=location.hash.substr(1).split('!')[1];let r=new XMLHttpRequest();r.open('GET','/crypto/snapshot/'+waveletId,true);r.onreadystatechange=function(){if(r.readyState!=4||r.status!=200){return}onServerResponse(JSON.parse(r.responseText))};r.send()})();">Decrypt wave</a> ([code](https://gist.github.com/llopv/f967b8cb74c5b3080f63de2114e6385d))

## Future work

## Quick links
* [List of commits][code]
* [How can Apache Wave Operational Transformations be encrypted? (Part 1)][encrypt-ot-1]
* [How can Apache Wave Operational Transformations be encrypted? (Part 2)][encrypt-ot-2]
* [Project code walkthrough][walkthrough]


[wave]: https://en.wikipedia.org/wiki/Apache_Wave
[ot]: https://en.wikipedia.org/wiki/Operational_transformation
[codecommit]: http://www.codecommit.com/blog/java/understanding-and-applying-operational-transformation
[paper]: http://www.tara.tcd.ie/bitstream/handle/2262/68179/paper.pdf;sequence=1
[code]: https://github.com/llopv/incubator-wave/tree/gsoc-2017
[encrypt-ot-1]: https://llopv.github.io/gsoc-2017/e2ee/2017/06/30/encrypt-ot-1.html
[encrypt-ot-2]: https://llopv.github.io/gsoc-2017/e2ee/2017/08/31/encrypt-ot-2.html
[walkthrough]: https://llopv.github.io/gsoc-2017/code/2017/08/31/code-walkthrough.html