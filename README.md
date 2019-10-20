# Einstein Platform Service

```sh
git clone https://github.com/takahitomiyamoto/einstein-platform-service.git
cd einstein-platform-service
sfdx force:org:create -s -a einsteinplatformservice -d 7 -f config/project-scratch-def.json
sfdx force:source:push -u einsteinplatformservice
sfdx force:user:permset:assign -n Einstein_Platform_Service -u einsteinplatformservice
sfdx force:user:password:generate -u einsteinplatformservice
sfdx force:user:display -u einsteinplatformservice
sfdx force:org:open -u einsteinplatformservice
```

## install AppExchange

- Einstein Vision and Language Model Builder
  - /packagingSetupUI/ipLanding.app?apvId=04t0b000001jiGJAAY
