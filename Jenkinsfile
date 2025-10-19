pipeline {
    agent any

    tools {
        // Configure Maven tool, replace 'Maven_3.8.6' with your configured Maven name in Global Tool Configuration
        maven 'Maven_3.9.9'
        // Configure JDK tool, replace 'JDK_11' with your configured JDK name in Global Tool Configuration
        jdk 'JDK_17'
    }

    stages {
        stage('Checkout') {
            steps {
                // Replace 'your-repository-url' and 'main' with your Git repository URL and branch
                git branch: 'master', url: 'https://github.com/techrecursion/test_devops.git'
            }
        }

        stage('Build') {
            steps {
                // Execute Maven clean and package goals
                sh 'mvn clean install'
            }
        }

        stage('Test') {
            steps {
                // Run Maven tests and publish JUnit test results
                sh 'mvn test'
                junit 'target/surefire-reports/**/*.xml'
            }
        }


        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image, tagging it with the registry and image name/tag
                    sh 'docker build -t abhi0401/test-devops:1.0 .'
                }
            }
        }

        stage('Push Image To DockerHub') {
                    steps {
                        script {
                            // Push the Docker image to Docker Hub
                            withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                                                sh 'docker login -u $DOCKERHUB_USERNAME -p $DOCKERHUB_PASSWORD'
                                                sh 'docker push abhi0401/test-devops:1.0'
                                                echo 'Docker image pushed to Docker Hub successfully.'
                                            }
                        }
                    }
                }

    }

    post {
        always {
            echo 'Pipeline finished.'
            sh 'docker logout'
        }
        success {
            echo 'Build successful!'
            mail to: 'ak0266680@gmail.com', subject: "Jenkins Build Success: ${env.JOB_NAME}", body: "Build ${env.BUILD_NUMBER} of ${env.JOB_NAME} is success. Check ${env.BUILD_URL} for details."
        }
        failure {
            echo 'Build failed!'
            mail to: 'ak0266680@gmail.com', subject: "Jenkins Build Failed: ${env.JOB_NAME}", body: "Build ${env.BUILD_NUMBER} of ${env.JOB_NAME} failed. Check ${env.BUILD_URL} for details."
        }
    }
}