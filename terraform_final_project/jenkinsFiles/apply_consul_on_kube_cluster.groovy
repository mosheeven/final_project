node('master'){

    stage('clone git repo'){
        git branch: 'master', changelog: false, credentialsId: 'github', poll: false, url: 'git@github.com:mosheeven/final_project.git'
    }

    stage('add secret'){
        sh 'kubectl create secret generic consul-gossip-encryption-key --from-literal=key="uDBV4e+LbFW3019YKPxIrg=="'
    }
    
    stage('run helom command'){
        dir('final_project/terraform_final_project/kubeFiles') {
            sh 'helm install consul hashicorp/consul -f values.yaml'
        }   
    }
}


