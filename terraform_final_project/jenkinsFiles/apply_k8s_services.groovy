// install filebaet, node-exporter, 
node('slave1'){

    stage('clone git repo'){
        git branch: 'master', changelog: false, credentialsId: 'github', poll: false, url: 'git@github.com:mosheeven/final_project.git'
    }

    stage("Install Cosnul on Kubernetes") {
            withCredentials([kubeconfigFile(credentialsId: 'kube', variable: 'KUBECONFIG')]) {
            sh '
            export KUBECONFIG=\${KUBECONFIG}
            kubectl get pods
            '
    }
}