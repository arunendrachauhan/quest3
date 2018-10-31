node{
    stage('SCM Checkout'){
	git credentialsId: 'gitcreds', url: 'https://github.com/arunendrachauhan/quest3'
    }
    stage('Mvn build'){
        def mvnHome = tool name: 'maven-3', type: 'maven'
        def mvnCMD = "${mvnHome}/bin/mvn"
        sh "${mvnCMD} clean package"
        sh 'mv target/myweb*.war target/myweb.war'
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
    stage('remove old container'){
        sshagent(['credapp-server']) {
	    withCredentials([string(credentialsId: 'docker-pwd', variable: 'dockerhubPwd')]) {
	    sh "docker login -u arunendradocker -p ${dockerhubPwd}"
	    try{
	      sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.20.164 docker stop ${ENV}"	
	      sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.20.164 docker rm ${ENV}"
	        }
	    catch(test){
	      sh 'echo no container present of this name'         
	        }
        }
        }
    }
    stage('run'){
	    sshagent(['credapp-server']) {
	    withCredentials([string(credentialsId: 'docker-pwd', variable: 'dockerhubPwd')]) {
	    sh "docker login -u arunendradocker -p ${dockerhubPwd}"
	    sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.20.164 docker pull arunendradocker/demoimg:${ENV}" 
	    //def dockerRun = sh "docker run -p 8085:8080 --name ${ENV} arunendradocker/demoimg:${ENV}"
	    sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.20.164 docker run -p 8085:8080 --name ${ENV} arunendradocker/demoimg:${ENV}"
	    sh 'echo container deployed successfully'
	    }
        }	
    }
}
