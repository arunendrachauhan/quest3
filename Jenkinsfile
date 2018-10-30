node{
    stage('SCM Checkout'){
	git credentialsId: 'gitcreds', url: 'https://github.com/arunendrachauhan/quest3'
    }
    stage('Mvn package'){
        def mvnHome = tool name: 'maven-3', type: 'maven'
        def mvnCMD = "${mvnHome}/bin/mvn"
        sh "${mvnCMD} clean package"	 
    }
    stage('Build Docker Image'){
        sh "docker build -t arunendradocker/demoimg:${ENV} ."
    }
    stage('Push Docker Image'){
	withCredentials([string(credentialsId: 'docker-pwd', variable: 'dockerhubPwd')]) {
	sh "docker login -u arunendradocker -p ${dockerhubPwd}"
	}
	sh "docker push arunendradocker/demoimg:${ENV}"
    }	
    stage('Run container on App server'){
	def dockerRun = sh "docker run --rm -p 8088:8080 -v jenkins-data:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock arunendradocker/demoimg:${ENV}"    
	sshagent(['credapp-server']) {
	sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.20.164 ${dockerRun}"
	}
	
    }
}

