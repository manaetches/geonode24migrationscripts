#!/bin/bash
read -p "Enter the Country you wish to restore:" COUNTRY

case "$COUNTRY" in
	Samoa | "Western Samoa" | WS)
    echo "Restoring Samoa"
    ./WS_restore.sh
    ;;
	Tonga | "The Kingdom of Tonga" | TO)
    echo "Restoring Tonga"
    ./TO_restore.sh
    ;;
	Sol | Solomons | "Solomon Islands" | SB)
	echo "Restoring Solomon Islands"
	#./restore_solomons.sh
	;;
	"Cook Islands" | Cooks | Rarotonga | CK)
    echo "Restoring Cook Islands"
    #./restore_cookislands.sh
    ;;
     "Fiji" | FJ )
    echo "Restoring Fiji"
    #./restore_fiji.sh
    ;;
    "Papua New Guinea" | Papua | PNG | PG)
    echo "Restoring Papua New Guinea"
    #./restore_png.sh
    ;;
    Palau | PU)
    echo "Restoring Palau"
    #./restore_palau.sh
    ;;
    Kiribati | KI)
    echo "Restoring Kiribati"
    #./restore_cookislands.sh
    ;;
    "Federated States of Micronesia" | FSM | FM)
    echo "Restoring Fedrated States of Micronesia"
    #./restore_cookislands.sh
    ;;
    "Niue" | NU )
    echo "Restoring Niue"
    #./restore_cookislands.sh
    ;;
    "Nauru" | NA )
    echo "Restoring Nauru"
    #./restore_nauru.sh
    ;;
     "Nauru" | NA )
    echo "Restoring Nauru"
    #./restore_nauru.sh
    ;;
     "Marshall Islands" | MH | "Marshalls")
    echo "Restoring Marshall Islands"
    #./restore_marshallislands.sh
    ;;
    "Vanuatu" | VU )
    echo "Restoring Vanuatu"
    #./restore_vanuatu.sh
    ;;
   "Tuvalu" | TV )
    echo "Restoring Tuvalu"
    #./restore_tuvalu.sh
    ;;  
   "Timor Leste" | TV | "Timor-Leste")
    echo "Restoring Timor Leste"
    #./restore_timorleste.sh
    ;;  
   "Tokelau" | TK)
    echo "Restoring Tokelau"
    #./restore_tokelau.sh
    ;;       
esac

