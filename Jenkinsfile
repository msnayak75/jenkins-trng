pipeline {
    agent {
        label "cicada-automation-node"
    }
    parameters {
        booleanParam(name: 'OSS_SCAN',
            defaultValue: false,
            description: 'Enable Blackduck Scan for this component overriding the global setting')
    }
    stages {
        stage('Preparing'){
	    steps{
		script{

		   readProperties(file: 'cicd/globalEnvVars.properties').each {
                        key,
                        value->env[key] = value
		   }

	        }

	    }
     
        }
		
		stage('Black-Duck Scan') {
            steps {

                script {
                    readProperties(file: 'cicd/globalEnvVars.properties').each {
                        key,
                        value->env[key] = value
                    }
                }

                sh '''
					bash cicd/bd_scan.sh
                 '''
            }
        }
		
	stage('CI Build') {
            parallel {
                stage('Preview Build') {
                    when {
                        branch 'PR-*'
                    }
                    steps {
                        script {
                            readProperties(file: 'cicd/globalEnvVars.properties').each {
                                key,
                                value->env[key] = value
                            }
                        }

                        sh '''
			  bash cicd/build.sh
                        '''
                    }
                }
                stage('Release Build') {
                    when {
                        branch 'release/*'
                    }
                    steps {

                        sh '''
			  bash cicd/build.sh
                        '''
                    }
                }
            }
        }
        stage('CI push snapshot') {
            parallel {
                stage('Preview Push') {
                    when {
                        branch 'PR-*'
                    }
                    steps {
                        script {
                            readProperties(file: 'cicd/globalEnvVars.properties').each {
                                key,
                                value->env[key] = value
                            }
                        }
                        sh '''
			   bash cicd/pr_push.sh
                        '''
                    }
                }
                stage('Release Push') {
                    when {
                        branch 'release/*'
                    }
                    steps {
                        sh '''
			   bash  cicd/release_push.sh
                        '''
                    }
                }
            }
        } 
        stage('Deploy') {
            parallel {
                stage('To Preview Cluster') {

                    when {
                        branch 'PR-*'
                    }

                    steps {

                        configFileProvider([configFile(fileId: 'dev_cluster', variable: 'DEV_CLUSTER')]) {
                            script {
                                readProperties(file: 'cicd/globalEnvVars.properties').each {
                                    key,
                                    value->env[key] = value
                                }
                            }
                            sh 'bash cicd/pr_deploy.sh'
                        }
                    }
                }
                stage('To Intergration Cluster') {

                    when {
                        branch 'release/*'
                    }

                    steps {

                        //Cleaning up preview namespace
                        configFileProvider([configFile(fileId: 'dev_cluster', variable: 'DEV_CLUSTER')]) {
                            script {
                                try {
				     sh '''
				      bash cicd/pr_cluster_cleanup.sh
				     '''
                                } catch (err) {
                                    echo "!!!UNABLE TO CLEAN UP PREVIEW NAMESPACE, Please make sure to clean manually!!!"
                                }
                            }
                        }

                        configFileProvider([configFile(fileId: 'integration_cluster', variable: 'INTEGRATION_CLUSTER')]) {
                            sh 'bash cicd/release_deploy.sh'
                        }
                    }
                }
            }
	}
    }
//    post {
//        always {
//          cleanWs()
//        }
//    }
}
