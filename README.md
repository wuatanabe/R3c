# R3c

[R3c.gem] (https://rubygems.org/gems/R3c)

Rest Redmine Ruby Client

Main Features:
* Most of the API is covered 
* Basic Auth and Key-based authentication are supported
* Check code for more usage examples

## Setup

```
gem install R3c
```

## Usage

### Configure Redmine URL

```
R3c.site('http://localhost:3000/')
```

### Set format

```
R3c.format(:xml)
```

### Configure Authentication

Key-based:
```
R3c.auth({api: {key: '8091d55257c4c90b6d56e83322622cb5f4ecee64'}})
```
Or Basic Auth (user/password):

```
R3c.auth({basic_auth: {user: 'admin', password: 'password'}})
```

###Prepare to create an issue with an attachment

```
file = File.read('c:\windows-version.txt')
token = R3c.upload file
issue_params= {"project_id"=> 1, "subject"=> "This is the subject"}
issue_params["uploads"]= [{"upload"=>{"token"=> token, "filename"=> "R3c.gemspec", "description"=> "a gemspec", "content_type"=> "text/plain"}}]
```

###Create the new issue

```
issue= R3c.issue.create(issue_params )
```

### Retrieve all projects

```
projects= R3c.project.all
```

### Find user by id

```
user= R3c.user.find 1
```

See code for more examples

