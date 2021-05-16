import csv
import string

line_count = 0

OutPut_Array = []
OutPut_ArrayNotMatch = [];
Contacts_MatchedFrom_Array = []

# Find Contacts that are Gift Aiders
with open('GiftAidContacts.csv') as csv_file:
    GA_Array = csv.reader(csv_file, delimiter=',')

    for row in GA_Array:

        if line_count == 0:
            line_count += 1
        else:
            line_count += 1

            colum0 = (row[0]).replace(" ", "")
            colum4 = (row[4]).replace(" ", "")

            if colum0 == "25" and colum4 == "1":
                Contacts_MatchedFrom_Array.append(row)

# Match Gift Aiders to Contacts Spreedsheet
for row in Contacts_MatchedFrom_Array:

    name_contactsReal = (row[2])
    name_contactsArray = name_contactsReal.split(" ", 10)
    name_contactsTitle = name_contactsArray[0]
    name_contactsFirstName = name_contactsArray[1]
    name_contactsSecondName = name_contactsArray[((len(name_contactsArray)) - 1)]
    name_contacts = (row[2]).replace(" ", "")

    postCode_contacts = row[9]

    address_contactsReal = (row[8]).split(",", 1)
    address_contactsRealsFirstWord = (address_contactsReal[0]).split(" ", 1)
    address_contactsRealNumberBool = (address_contactsRealsFirstWord[0]).isalpha()
    if address_contactsRealNumberBool:
        address_contacts = str(address_contactsReal[0])
    else:
        address_contacts = address_contactsRealsFirstWord[0]


    with open('BankTransfers.csv') as csv_file:
        BT_Array = csv.reader(csv_file, delimiter=',')
        BT_MatchedArray = []

        totalDonations = 0
        totalDonationsCount = 0;
        donationDate = ""
        tempArray = []

        for row in BT_Array:
            name_bankT = (row[3]).replace(" ", "")

            if name_contacts.lower() == name_bankT.lower():
                totalDonations += float(row[4])
                totalDonationsCount += 1
                donationDate = row[0]
                tempArray = [name_contactsTitle,name_contactsFirstName,name_contactsSecondName,address_contacts,postCode_contacts,"","",donationDate,totalDonations, "Don. Instances: "+ str(totalDonationsCount)]

        if str(tempArray) != "[]":
            #print(f'{tempArray}')
            OutPut_Array.append(tempArray)
        else:
            OutPut_ArrayNotMatch.append(tempArray)

# Output to CSV format
for row in OutPut_Array:
    outPutText = "";
    for c in row:
        outPutText = outPutText + str(c) + ","
    print(f'{outPutText}')

print(f'\n\nNo Matches\n\n')

for row in Contacts_MatchedFrom_Array:
    outPutText = "";
    for c in row:
        outPutText = outPutText + str(c) + ","
    print(f'{Contacts_MatchedFrom_Array}')