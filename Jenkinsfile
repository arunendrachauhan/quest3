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
	def dockerRun = 'docker run -d -p 8080:8080 --name myapp demoimg:0.1'
	sshagent(['credapp-server']) {
	sh "ssh -o StrictHostKeyChecking=no ubuntu@ec2-13-126-229-86.ap-south-1.compute.amazonaws.com ${dockerRun}"
	}
    }	
}
