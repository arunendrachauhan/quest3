node{
    stage('SCM Checkout'){
	sh 'usermod -aG docker jenkins'
	sh 'service jenkins restart'    
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
}
