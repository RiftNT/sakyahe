firebase.initializeApp(firebaseConfig);
const db = firebase.firestore();

function populateUserTable() {
  const tableBody = document.getElementById("userTableBody");

  db.collection("users")
    .get()
    .then((querySnapshot) => {
      querySnapshot.forEach((doc) => {
        const userData = doc.data();
        const row = document.createElement("tr");

        const uidCell = document.createElement("td");
        uidCell.textContent = userData.uid;
        row.appendChild(uidCell);

        const nameCell = document.createElement("td");
        nameCell.textContent = userData.name;
        row.appendChild(nameCell);

        const phoneNumber = document.createElement("td");
        phoneNumber.textContent = userData.phoneNumber;
        row.appendChild(phoneNumber);

        const typeCell = document.createElement("td");
        typeCell.textContent = userData.type;
        row.appendChild(typeCell);

        row.addEventListener("click", () => {
          document.getElementById("userId").value = userData.uid;
        });

        tableBody.appendChild(row);
      });
    })
    .catch((error) => {
      console.log("Error getting driver details: ", error);
    });
}

function populateDriverTable() {
  const tableBody = document.getElementById("driverTableBody");

  db.collection("driver_details")
    .where("userID", "==", "")
    .get()
    .then((querySnapshot) => {
      querySnapshot.forEach((doc) => {
        const driverData = doc.data();
        const row = document.createElement("tr");

        const driverIdCell = document.createElement("td");
        driverIdCell.textContent = doc.id;
        row.appendChild(driverIdCell);

        const birthDateCell = document.createElement("td");
        birthDateCell.textContent = driverData.birthDate;
        row.appendChild(birthDateCell);

        const carCapacityCell = document.createElement("td");
        carCapacityCell.textContent = driverData.carCapacity;
        row.appendChild(carCapacityCell);

        const carColorCell = document.createElement("td");
        carColorCell.textContent = driverData.carColor;
        row.appendChild(carColorCell);

        const carMakeCell = document.createElement("td");
        carMakeCell.textContent = driverData.carMake;
        row.appendChild(carMakeCell);

        const carPlateNoCell = document.createElement("td");
        carPlateNoCell.textContent = driverData.carPlate;
        row.appendChild(carPlateNoCell);

        const carTypeCell = document.createElement("td");
        carTypeCell.textContent = driverData.carType;
        row.appendChild(carTypeCell);

        const firstNameCell = document.createElement("td");
        firstNameCell.textContent = driverData.firstName;
        row.appendChild(firstNameCell);

        const genderCell = document.createElement("td");
        genderCell.textContent = driverData.gender;
        row.appendChild(genderCell);

        const governmentIdCell = document.createElement("td");
        governmentIdCell.textContent = driverData.governmentId;
        row.appendChild(governmentIdCell);

        const lastNameCell = document.createElement("td");
        lastNameCell.textContent = driverData.lastName;
        row.appendChild(lastNameCell);

        const middleNameCell = document.createElement("td");
        middleNameCell.textContent = driverData.middleName;
        row.appendChild(middleNameCell);

        const phoneNumberCell = document.createElement("td");
        phoneNumberCell.textContent = driverData.phoneNumber;
        row.appendChild(phoneNumberCell);

        row.addEventListener("click", () => {
          document.getElementById("driverId").value = doc.id;
        });

        tableBody.appendChild(row);
      });
    })
    .catch((error) => {
      console.log("Error getting driver details: ", error);
    });
}

window.addEventListener("DOMContentLoaded", () => {
  populateUserTable();
  populateDriverTable();

  const assignDriverForm = document.getElementById("assignDriverForm");
  assignDriverForm.addEventListener("submit", assignDriver);
});

function assignDriver(event) {
    event.preventDefault();
  
    const assignDriverForm = document.getElementById("assignDriverForm");
    const driverIdInput = document.getElementById("driverId");
  
    const driverId = driverIdInput.value;
  
    db.collection("driver_details")
      .doc(driverId)
      .get()
      .then((doc) => {
        if (doc.exists) {
          const driverData = doc.data();
  
          const firstName = driverData.firstName;
          const middleName = driverData.middleName;
          const lastName = driverData.lastName;
          const phoneNumber = driverData.phoneNumber;
  
          const userName = `${firstName} ${middleName.charAt(0)}. ${lastName}`;
  
          db.collection("users")
            .add({
              name: userName,
              phoneNumber: phoneNumber,
              type: "driver",
            })
            .then((docRef) => {
              const generatedUid = docRef.id;
  
              db.collection("driver_details")
                .doc(driverId)
                .update({
                  userID: generatedUid,
                })
                .then(() => {
                  console.log("User ID added to driver details successfully!");
  
                  db.collection("users")
                    .doc(generatedUid)
                    .update({
                      uid: generatedUid,
                    })
                    .then(() => {
                      console.log("User assigned as driver successfully!");
                      assignDriverForm.reset();
                    })
                    .catch((error) => {
                      console.log("Error updating UID: ", error);
                    });
                })
                .catch((error) => {
                  console.log("Error adding user ID to driver details: ", error);
                });
            })
            .catch((error) => {
              console.log("Error creating user: ", error);
            });
        } else {
          console.log("Driver details not found!");
        }
      })
      .catch((error) => {
        console.log("Error getting driver details: ", error);
      });
  }
  
  
