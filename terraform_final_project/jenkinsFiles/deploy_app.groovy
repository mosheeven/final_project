node('master'){
    stage('clone git'){
        git branch: 'master', changelog: false, credentialsId: 'github', poll: false, url: 'git@github.com:mosheeven/final_project.git'
    }
    
    stage('deploy app'){
        kubernetesDeploy configs: 'terraform_final_project/kubeFiles/pod-svc.yaml, terraform_final_project/kubeFiles/pod1.yaml', kubeConfig: [path: ''], kubeconfigId: 'KubeAccess', secretName: '', ssh: [sshCredentialsId: '*', sshServer: ''], textCredentials: [certificateAuthorityData: '', clientCertificateData: '', clientKeyData: '', serverUrl: 'https://']
    }
}