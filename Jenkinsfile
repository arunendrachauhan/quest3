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
        sh 'docker build -t demoimg:0.1 .'
    }
    stage('Run container on App server'){
	//sh 'docker rm my-appserver'    
	def dockerRun = 'docker run -p 8080:8080 -d --name my-appserver demoimg:0.1'
	sshagent(['credapp-server']) {
	sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.22.38 ${dockerRun}"
      }
    }	
}
