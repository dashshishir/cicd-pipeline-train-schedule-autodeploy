pipeline {
    agent {
      label 'javaslave1'
    }
    environment {
        DOCKER_REGISTRY = "docker.io"
        DOCKERHUB_REPO = "dashshishir/devopsedu"
        DOCKER_IMAGE_TAG = "latest"
        DOCKERHUB_CREDENTIALS_ID = "docker-hub"
    }
    
    stages {
        stage('Clone Git Repo') {
            steps {
                git(
                    url: 'https://github.com/dashshishir/cicd-pipeline-train-schedule-autodeploy.git',
                    branch: 'master'
                )
            }
        }

        stage('Build'){
          steps {
            sh 'docker build -t ${DOCKER_REGISTRY}/${DOCKERHUB_REPO}:${DOCKER_IMAGE_TAG} .'
          }
        }
        stage('Push') {
          steps {
            withCredentials([usernamePassword(credentialsId: DOCKERHUB_CREDENTIALS_ID, usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_ACCESS_TOKEN')]) {
                    sh "docker login -u ${DOCKERHUB_USERNAME} -p ${DOCKERHUB_ACCESS_TOKEN} ${DOCKER_REGISTRY}"
                    sh "docker push ${DOCKER_REGISTRY}/${DOCKERHUB_REPO}:${DOCKER_IMAGE_TAG}"
                }
          }
        }
        stage('Deploy to Kubernetes Cluster') {
            steps {
                ansiblePlaybook(
                    playbook: 'ansible/deploy-playbook.yaml',
                    become: true,
                    colorized: true
                )
            }
        }
    }
}