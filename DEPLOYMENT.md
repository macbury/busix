## Setup

Install required roles playbooks

```
ansible-galaxy install -r deployment/install_roles.yml
```

## Prepare DigiralOcean instance

```
ansible-playbook deployment/orchiestrate.yml
```

On command run you will be asked for stage, which can be production/staging or other name. Wait for instance to be running.

## Instance provision

Put env configuration inside:

```
/etc/profile.d/busix.sh
```

Run command:

```
ansible-playbook deployment/provision.yml 
```

You will be askied for stage that will be used to find instance host.

## Deployment

To deploy code and restart all needed services:

```
bin/cap <stage> deploy
```

Run `bin/cap <stage> -T` to see more available tasks.

