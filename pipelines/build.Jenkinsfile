// pipelines/build.Jenkinsfile

pipeline {
    agent {
        label 'general' //first commit
    }

    triggers {
        githubPush()
    }

    stages {
        stage('Build app container') {
            steps {
                sh '''
                    docker build -t netflix-movie-catalog .
                '''
            }
        }
    }
}