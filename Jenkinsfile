node ('docker') {
  properties([
    parameters([
      stringParam(
        defaultValue: 'mr5.2.1',
        description: 'RTP Engine release',
        name: 'RTPver'
      )
    ])
  ])

  stage('Pull from SCM') {
    checkout([$class: 'GitSCM', branches: [[name: '*/' + params.RTPver]],
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
    
  }
}
