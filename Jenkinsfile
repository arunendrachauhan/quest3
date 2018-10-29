node{
    stage('SCM Checkout'){
	git credentialsId: 'mygitcred', url: 'https://github.com/arunendrachauhan/quest3'
    }
    stage('Mvn package'){
        def mvnHome = tool name: 'maven-3', type: 'maven'
        def mvnCMD = "${mvnHome}/bin/mvn"
        sh "${mvnCMD} clean package"	 
    }
    stage('Build Docker Image'){
        sh 'docker build -t arunendradocker/demoimg:0.1 .'
    }
    stage('Push Docker Image'){
	withCredentials([string(credentialsId: 'docker-pwd', variable: 'dockerhubPwd')]) {
	sh "docker login -u arunendradocker -p ${dockerhubPwd}"
	}
	sh 'docker push arunendradocker/demoimg:0.1'
    }	
    stage('Run container on App server'){
	//def dockerHome = tool name: 'docker-18', type: 'org.jenkinsci.plugins.docker.commons.tools.DockerTool'
	//def dockerCMD = "${dockerHome}/bin/docker"    
	//def dockerRun = 
	//sh 'docker run -d -p 8085:8080 --name myapp arunendradocker/demoimg:0.1'
	def dockerRun = sh "docker run --rm -p 8085:8080 -v jenkins-data:/var/jenkins_home -v $(which docker):/usr/bin/docker -v /var/run/docker.sock:/var/run/docker.sock -v "$HOME":/home arunendradocker/demoimg:0.1"    
	sshagent(['credapp-server']) {
	
	sh "ssh -o StrictHostKeyChecking=no ec2-user@13.233.98.24 ${dockerRun}"
	}
	
    }

}
