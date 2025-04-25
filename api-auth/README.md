
# API-AUTH

## custom-header:

**start-api command:**

This command executes an API task within the local context of the Truebit Node. 

```
truebit start-api api-auth/custom-header/custom-header.manifest.json api-auth/custom-header/custom-header.input.json custom-header 'username:foo, password:bar'
```

**deploy command:**

First step we run the following command to create the Truebit API Task and upload the manifest to the local storage. As a result, it returns the taskId.

```
truebit create-api api-auth/custom-header/custom-header.manifest.json
```

Next, we run the deploy command with the taskId just returned by create-api command. This deploys and registers a new Truebit task specified by the --taskId parameter. Using the deploy command makes the Truebit task available for execution.

```
truebit deploy <namespace> <taskname> --taskId <taskId>
```

At least, run api-auth command that specifies authentication for the truebit api task.

```
truebit api-auth <namespace> <taskname> <taskId> custom-header "username:<username>,password:<password>"
```

## basic-auth:

**start-api command:**

This command executes an API task within the local context of the Truebit Node.

```
truebit start-api api-auth/basic-auth/basic-auth.manifest.json api-auth/basic-auth/basic-auth.input.json basic-auth 'username:<username>,password:<password>'
```

**deploy command:**

First step we run the following command to create the Truebit API Task and upload the manifest to the local storage. As a result, it returns the taskId.

```
truebit create-api api-auth/basic-auth/basic-auth.manifest.json
```

Next, we run the deploy command with the taskId just returned by create-api command. This deploys and registers a new Truebit task specified by the --taskId parameter. Using the deploy command makes the Truebit task available for execution.

```
truebit deploy <namespace> <taskname> --taskId <taskId>
```
At least, run api-auth command that specifies authentication for the truebit api task.

```
truebit api-auth <namespace> <taskname> <taskId> basic-auth 'username:<username>,password:<password>'
```

## aws-signature:

**start-api command:**

This command executes an API task within the local context of the Truebit Node.

```
truebit start-api api-auth/aws-signature/aws-signature.manifest.json api-auth/aws-signature/aws-signature.input.json aws-signature "accessKey:AKIA2VXUSRQO3CTJ5UH5,secretKey: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"
```

**deploy command:**

First step we run the following command to create the Truebit API Task and upload the manifest to the local storage. As a result, it returns the taskId.

```
truebit create-api api-auth/aws-signature/aws-signature.manifest.json
```

Next, we run the deploy command with the taskId just returned by create-api command. This deploys and registers a new Truebit task specified by the --taskId parameter. Using the deploy command makes the Truebit task available for execution.

```
truebit deploy <namespace> <taskname> --taskId <taskId>
```

At least, run api-auth command that specifies authentication for the truebit api task.

```
truebit api-auth <namespace> <taskname> <taskId> aws-signature "accessKey:AKIA2VXUSRQO3CTJ5UH5,secretKey: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"
```