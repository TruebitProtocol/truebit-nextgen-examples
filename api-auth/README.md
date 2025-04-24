
# custom-header:

* start-api command:

```
npx truebit start-api custom-header/custom-header.manifest.json custom-header/custom-header.input.json custom-header 'token:password'
```

* deploy command:
```
npx truebit create-api custom-header/custom-header.manifest.json

npx truebit deploy namespace taskname --taskId taskId

npx truebit api-auth namespace taskname taskId aws-signature "username:<username>,password:<password>"
```

# basic-auth:

* start-api command:

```
npx truebit start-api basic-auth/basic-auth.manifest.json basic-auth/basic-auth.input.json basic-auth 'username:foo,password:bar'ç
```

* deploy command:

```
npx truebit create-api basic-auth/basic-auth.manifest.json

npx truebit deploy namespace taskname --taskId taskId

npx truebit api-auth namespace taskname taskId aws-signature "username:<username>,password:<password>"
```

# aws-signature:

* start-api command:
```
npx truebit start-api aws-signature/aws-signature.manifest.json aws-signature/aws-signature.input.json aws-signature accessKey:AKIA2VXUSRQO3CTJ5UH5,secretKey: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
```

* deploy command:

```
npx truebit create-api aws-signature/aws-signature.manifest.json

npx truebit deploy namespace taskname --taskId taskId

npx truebit api-auth namespace taskname taskId aws-signature "username:<username>,password:<password>"
```