node ('docker') {
  properties([
    parameters([
      stringParam(
        defaultValue: '5.2.1',
        description: 'RTP Engine release',
        name: 'RTPver'
      )
    ])
  ])

  stage('Pull from SCM') {
    checkout([$class: 'GitSCM', branches: [[name: '*/mr' + params.RTPver]],
              userRemoteConfigs: [[url:'https://github.com/kekullc/rtpengine.git'],[credentialsId: '66085b7b-d779-4ef6-aff8-bf15e279d096']]
            ])
  }

  stage('Preparing development container') {
    def container = docker.build('rtpengine_container', '.')
  }

  stage('Build RTP Engine') {
    def container = docker.image('rtpengine_container')
    container.inside('-u 0 -v ${JENKINS_HOME}:/git') {
      sh './debian/flavors/no_ngcp'
      sh 'dpkg-buildpackage'
      sh 'mv ../*.deb ./'
    }
  }

  stage('Publish to Bintray') {
    sh 'for i in $(find -name "*.deb" -type f -exec basename {} \;); do curl -X PUT -T $i -uavinogradov:3448eb8ea80b5e0f11624f776c92632596c0f930 -H "X-Bintray-Package:ngcp-rtpengine" -H "X-Bintray-Version:5.2.1" -H "X-Bintray-Debian-Distribution:xenial" -H "X-Bintray-Debian-Component:main" -H "X-Bintray-Debian-Architecture:amd64" -H "X-Bintray-Publish:1" -H "X-Bintray-Override:1" -H "X-Bintray-Explode:0" https://api.bintray.com/content/stanacard/ngcp-rtpengine/main/n/ngcp-rtpengine/' + RTPver + '/$i; done'
  }
}
