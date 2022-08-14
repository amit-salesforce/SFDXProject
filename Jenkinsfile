#!groovy
import groovy.json.JsonSlurperClassic
node {

    def BUILD_NUMBER=env.BUILD_NUMBER
    def RUN_ARTIFACT_DIR="tests/${BUILD_NUMBER}"
    def SFDC_USERNAME

    def SF_USERNAME=env.SF_USERNAME
    def SF_INSTANCE_URL = env.SF_INSTANCE_URL ?: "https://login.salesforce.com"
    def SERVER_KEY_CREDENTALS_ID=env.SERVER_KEY_CREDENTALS_ID
    def SF_CONSUMER_KEY=env.SF_CONSUMER_KEY

    println 'KEY IS' 
    println SERVER_KEY_CREDENTALS_ID
    println SF_USERNAME
    println SF_INSTANCE_URL
    println SF_CONSUMER_KEY
	
    def toolbelt = tool 'toolbelt'
    
    // -------------------------------------------------------------------------
    // Check out code from source control.
    // -------------------------------------------------------------------------

    stage('checkout source') {
        // when running in multi-branch job, one must issue this command
        checkout scm
    }

    // -------------------------------------------------------------------------
    // Run all the enclosed stages with access to the Salesforce
    // JWT key credentials.
    // -------------------------------------------------------------------------
    
    withEnv(["HOME=${env.WORKSPACE}"]) {
        
        withCredentials([file(credentialsId: SERVER_KEY_CREDENTALS_ID, variable: 'server_key_file')]) {	
	
   	    // -------------------------------------------------------------------------
            // Authorize the Dev Hub org with JWT key and give it an alias.
            // -------------------------------------------------------------------------

            stage('Authorize DevHub') {
                rc = command "\"${toolbelt}\" force:auth:jwt:grant --clientid ${SERVER_KEY_CREDENTALS_ID} --username ${SF_USERNAME} --jwtkeyfile \"${server_key_file}\" --setdefaultdevhubusername --instanceurl ${SF_INSTANCE_URL}"
                if (rc != 0) {
                    error 'Salesforce dev hub org authorization failed.'
                }
            }
		
	   // stage('Deploy Code') {
	   //	rc = command "\"${toolbelt}\sfdx" force:mdapi:deploy -d manifest/. -u ${SF_USERNAME}"
	   //	if (rc != 0) {
           //         error 'Salesforce deploy failed'
           //     }
           // }
	}
    }
}

def command(script) {
    if (isUnix()) {
        return sh(returnStatus: true, script: script);
    } else {
        return bat(returnStatus: true, script: script);
    }
}
