while getopts d: flag
do
    case "${flag}" in
        d) directory=${OPTARG};;
    esac
done

cd ..

npx expo export --experimental-bundle

mkdir -p updates/$directory/

rm -rf updates/$directory/

cp -r dist updates/$directory

node scripts/exportClientExpoConfig.js > updates/$directory/expoConfig.json

ssh root@42.192.127.54 << remotessh
cd ~/expo-updates-server/updates
mkdir -p $directory/
remotessh

scp  -r updates/$directory  root@42.192.127.54:~/expo-updates-server/updates/$directory

