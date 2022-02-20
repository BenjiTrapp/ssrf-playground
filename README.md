[![Docker](https://github.com/BenjiTrapp/ssrf-playground/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/BenjiTrapp/ssrf-playground/actions/workflows/docker-publish.yml)

![](www/static/tag.png)

<br><br>
<img height="200" align="left" src="www/static/evilmonkey.png" > <br>Use this tiny playground to get more intouch with SSRF. This Challenge is thought to be part of a CTF Event and works fine in combination with CTFd or Facebooks CTF Framework. During your campaign this [SSRF Cheatsheet](https://cheatsheetseries.owasp.org/cheatsheets/Server_Side_Request_Forgery_Prevention_Cheat_Sheet.html) might help you.
<br><br>
<br><br>
<br><br>

### How to get started
The easiest way is to use the prebuild Docker image and spin the docker container up like usual: 

```bash
docker pull ghcr.io/benjitrapp/ssrf-playground:main
```

Otherwise you can also build and run the Dockerfile locally. To start this simply use the Makefile like this:

```bash
make all
```

### Still under construction

some more flags will be added later. This app is broken by design so be careful what you do with it and where you deploy it! IN near future this app will use a mocked Metadata Service from AWS and be combined with Localstack to go some steps further.
