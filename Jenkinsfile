#!groovy
import groovy.json.JsonSlurperClassic
node {
 
    def BUILD_NUMBER=env.BUILD_NUMBER
    def RUN_ARTIFACT_DIR="tests/${BUILD_NUMBER}"
    def SFDC_USERNAME
 
    def HUB_ORG=env.HUB_ORG_DH
    def SFDC_HOST = env.SFDC_HOST_DH
    def JWT_KEY_CRED_ID = env.JWT_CRED_ID_DH
    def CONNECTED_APP_CONSUMER_KEY=env.CONNECTED_APP_CONSUMER_KEY_DH
 
    println 'KEY IS' 
    println JWT_KEY_CRED_ID
    println HUB_ORG
    println SFDC_HOST
    println CONNECTED_APP_CONSUMER_KEY
    def toolbelt = tool 'toolbelt'
 
    
 
    withCredentials([file(credentialsId: JWT_KEY_CRED_ID, variable: 'jwt_key_file')]) {
    
    stages {
        stage('Build') {
            steps {                
                git 'https://github.com/agale007/SFDXProject.git'
            }
        }
        
        stage('Deploye Code') {
            if (isUnix()) {
                rc = sh returnStatus: true, script: "${toolbelt} sfdx force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile ${jwt_key_file} --setdefaultusername --instanceurl ${SFDC_HOST}"
            }else{
                
         rc = bat returnStatus: true, script: "sfdx force:auth:jwt:grant --clientid ${CONNECTED_APP_CONSUMER_KEY} --username ${HUB_ORG} --jwtkeyfile \"${jwt_key_file}\" --setdefaultusername --instanceurl ${SFDC_HOST}"
            }
            if (rc != 0) { error 'hub org authorization failed' }
 
            println rc
            
            // need to pull out assigned username
            if (isUnix()) {
                rmsg = sh returnStdout: true, script: "${toolbelt} force:mdapi:deploy -d manifest/package.xml -u ${HUB_ORG}"
            }else{
               //bat returnStdout: true, script: "git clone https://github.com/agale007/SFDXProject.git"
                //bat returnStdout: true, script: "cd new pipeline@script"
                rmsg = bat returnStdout: true, script: "sfdx force:source:deploy --manifest manfiest/package.xml --json --loglevel fatal -u ${HUB_ORG}"
            }
              
            printf rmsg
            println('Hello from a Job DSL script!')
            println(rmsg)
        }
    }
}
