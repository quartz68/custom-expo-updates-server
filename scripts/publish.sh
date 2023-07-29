while getopts d: flag
do
    case "${flag}" in
        d) directory=${OPTARG};;
    esac
done

cd ..

npx expo export --experimental-bundle

rm -rf updates/$directory/

cp -r dist updates/$directory

node scripts/exportClientExpoConfig.js > updates/$directory/expoConfig.json

# scp  -r updates/$directory  root@42.192.127.54:~/expo-updates-server/updates/$directory

