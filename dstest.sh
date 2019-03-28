###################TEST_Connection############
:'
Created at Thur 28 Mar 2019
------------
@ Author : Pushparaj Karthick D(NPI)
'
set -x;

While IFS= read -r line
do
Nn+=("$line")
done < /tmp/ds.txt

count=$(wc -l | /tmp/ds.txt | sed "s/[^0-9]//g;")

echo $count
echo "DSName" > /tmp/Test_Result.csv
echo "Status" > /tmp/Test_Result.csv
for ((i=0;i<"$count";i++))
do
status=$(/opt/Solartis_Starr/dc/bin/jboss-cli.sh -c controller=host_IP --user=Console_user --paswword=Console_Password --command="/host=qakbhc1/server=26_CHIC_RRFW1.1/subsystem=datasources/data-source="${Nn[i]}":test-connection-in-pool()" | grep "outcome" | awk {'print $3'})
echo ${Nn[i]} >> /tmp/Test_Result.csv
echo $status >> /tmp/Test_Result.csv
