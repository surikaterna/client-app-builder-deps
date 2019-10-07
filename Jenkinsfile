podTemplate(
  containers: [
    containerTemplate(name: 'docker', image: 'joelroxell/docker-make:1.0.0', ttyEnabled: true, command: 'cat'),
    containerTemplate(name: 'aws', image: 'atlassian/pipelines-awscli', ttyEnabled: true, command: 'cat')
  ],
  volumes: [
    hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock')
  ]
) {
  node(POD_LABEL) {
        def myRepo = checkout scm
        def commit = myRepo.GIT_COMMIT
        def branch = myRepo.GIT_BRANCH
        def docker_login
        def registry = '534530887062.dkr.ecr.eu-west-1.amazonaws.com/surikat-builder'
        def tag = sh(returnStdout: true, script: "git tag --contains")
        def dockerImageName = "surikat-builder"

        if (!tag) { tag = commit }

        stage('build image') {
            container('docker') {
                sh "echo ${tag}"
                sh "make build tag=${tag}"
            }
        }

        if (branch == 'master')  {
            stage('push image') {
                container('aws') {
                    docker_login = sh(returnStdout: true, script: 'aws ecr get-login --no-include-email --region eu-west-1')
                }

                container('docker') {
                    sh """
                    ${docker_login}
                    docker tag ${dockerImageName}:${tag} ${registry}:${tag}
                    docker push ${registry}:${tag}
                    """
                }
            }
        }
    }
}