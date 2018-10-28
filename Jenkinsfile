node{
    stage('SCM Checkout'){
        git credentialsId: 'mygitcred', url: 'https://github.com/arunendrachauhan/quest3'
    }
    stage('Mvn package'){
        sh 'mvn clean package'
    }
}
