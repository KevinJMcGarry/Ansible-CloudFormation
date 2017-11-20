# Ansible with Docker


#### Ansible Demonstration using Docker-Compose for the environment  

* Generate local ssh keypair for Ansible User:

    ```bash
    ssh-keygen -t rsa -f ansible
    copy keypair to env/ folder from repo **
    ** note this is just for demonstration purposes. The Docker Images will be built with the keypair included. This is never done in the real world.    
    # react native cli
    npm install react-native-cli -g
    ```

* Install XCode 8.3+ (for iOS development)
* Install Android Studio 1.5+ (for Android development)

* Install app dependencies

    ```bash
    # from RehearScoreMobile directory
    yarn install
    ```

### Run iOS in Simulator

```bash
# from RehearScoreMobile directory
npm run start:ios
```

### Run Android in Emulator

You must have an Android emulator running. The following command will list all running emulators:

```bash
# list running Android emulators
adb devices
```

Then run the build:

```bash
# from RehearScoreMobile directory
npm run start:android
```

### Running Tests

```bash
# from RehearScoreMobile directory
npm test
```