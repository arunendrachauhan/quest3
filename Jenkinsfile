node{
    stage('SCM Checkout'){
        git credentialsId: 'mygitcred', url: 'https://github.com/arunendrachauhan/quest3'
    }
    stage('Mvn package'){
        def mvnHome = tool name: 'maven-3', type: 'maven'
        def mvnCMD = "${mvnHome}/bin/mvn"
        sh "${mvnCMD} clean package"
	sh 'sudo usermod -a -G docker jenkins'
	sh 'sudo service jenkins restart'    
    }
	stage('Build Docker Image'){
        sh 'docker build -t demoimg:0.1 .'
    }
}
