
CREATE DATABASE SmartAutoCheck;
USE SmartAutoCheck;


CREATE TABLE USERS (
    id_user INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'inspector', 'client') DEFAULT 'client'
);


CREATE TABLE INSPECTORS (
    id_inspector INT PRIMARY KEY AUTO_INCREMENT,
    nom_ins VARCHAR(50) NOT NULL,
    prenom_ins VARCHAR(50),
    matricul_pro VARCHAR(50) UNIQUE,
    id_user INT UNIQUE,
    FOREIGN KEY (id_user) REFERENCES USERS(id_user) ON DELETE CASCADE
);


CREATE TABLE CLIENTS (
    id_client INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50),
    cin VARCHAR(20) UNIQUE,
    tel VARCHAR(20),
    adresse TEXT,
    ville VARCHAR(50),
    id_user INT UNIQUE,
    FOREIGN KEY (id_user) REFERENCES USERS(id_user) ON DELETE CASCADE
);


CREATE TABLE VEHICLES (
    id_vehicle INT PRIMARY KEY AUTO_INCREMENT,
    matricule VARCHAR(30) UNIQUE NOT NULL,
    marque VARCHAR(50),
    model VARCHAR(50),
    num_chassis VARCHAR(100) UNIQUE,
    type_carburant ENUM('Essence', 'Diesel', 'Hybride', 'Electrique'),
    id_client INT,
    FOREIGN KEY (id_client) REFERENCES CLIENTS(id_client) ON DELETE SET NULL
);


CREATE TABLE RENDEZ_VOUS (
    id_rdv INT PRIMARY KEY AUTO_INCREMENT,
    date_rdv DATE NOT NULL,
    heure_rdv TIME NOT NULL,
    status ENUM('en_attente', 'confirme', 'annule', 'termine') DEFAULT 'en_attente',
    code_confirmation VARCHAR(10) UNIQUE,
    id_vehicle INT,
    FOREIGN KEY (id_vehicle) REFERENCES VEHICLES(id_vehicle) ON DELETE CASCADE
);


CREATE TABLE RAPPORT (
    id_rapport INT PRIMARY KEY AUTO_INCREMENT,
    date_rapport DATETIME DEFAULT CURRENT_TIMESTAMP,
    kilometrage INT,
    prix_total DECIMAL(10, 2),
    resultat_final ENUM('favorable', 'defavorable'),
    rapport_recommandations TEXT,
    id_rdv INT UNIQUE,
    id_inspector INT,
    FOREIGN KEY (id_rdv) REFERENCES RENDEZ_VOUS(id_rdv),
    FOREIGN KEY (id_inspector) REFERENCES INSPECTORS(id_inspector)
);


CREATE TABLE TEST_CATALOG (
    id_test INT PRIMARY KEY AUTO_INCREMENT,
    nom_test VARCHAR(100) NOT NULL,
    valeur_max DECIMAL(10, 2),
    valeur_min DECIMAL(10, 2),
    est_obligatoire BOOLEAN DEFAULT TRUE,
    description TEXT
);


CREATE TABLE INSPECTIONS (
    id_test INT,
    id_rapport INT,
    valeur_trouvee DECIMAL(10, 2),
    etat_test ENUM('valide', 'echec'),
    PRIMARY KEY (id_test, id_rapport),
    FOREIGN KEY (id_test) REFERENCES TEST_CATALOG(id_test),
    FOREIGN KEY (id_rapport) REFERENCES RAPPORT(id_rapport)
);


INSERT INTO USERS (email, password, role) VALUES 
('admin@autocheck.ma', 'hash_admin_2026', 'admin'),
('y.alami@autocheck.ma', 'hash_insp_1', 'inspector'),
('m.hassani@autocheck.ma', 'hash_insp_2', 'inspector'),
('othmane.benz@email.com', 'pass_othmane', 'client'),
('hamza.idrissi@email.com', 'pass_hamza', 'client'),
('sara.berrada@email.com', 'pass_sara', 'client'),
('khalid.mansouri@email.com', 'pass_khalid', 'client'),
('anouar.zaki@email.com', 'pass_anouar', 'client');

INSERT INTO INSPECTORS (nom_ins, prenom_ins, matricul_pro, id_user) VALUES 
('ALAMI', 'Yassine', 'MAT-2026-X1', 2),
('HASSANI', 'Mohamed', 'MAT-2026-X2', 3);

INSERT INTO CLIENTS (nom, prenom, cin, tel, ville, id_user) VALUES 
('BENZAKOUR', 'Othmane', 'K123456', '0661112233', 'Safi', 4),
('EL IDRISSI', 'Hamza', 'G998877', '0662223344', 'Marrakech', 5),
('BERRADA', 'Sara', 'F445566', '0663334455', 'Casablanca', 6),
('MANSOURI', 'Khalid', 'H112233', '0664445566', 'Agadir', 7),
('ZAKI', 'Anouar', 'AB00000', '0665556677', 'Safi', 8);


INSERT INTO VEHICLES (matricule, marque, model, num_chassis, type_carburant, id_client) VALUES 
('1-A-123', 'Volkswagen', 'Touareg', 'WVZ111222333', 'Diesel', 1),
('6-B-456', 'Mercedes', 'W204', 'WDC444555666', 'Essence', 1), 
('26-M-789', 'Dacia', 'Duster', 'UU1777888999', 'Diesel', 2),
('33-C-101', 'Renault', 'Clio 4', 'VF1010101010', 'Essence', 3),
('10-AG-202', 'Tesla', 'Model 3', '5YJ202020202', 'Electrique', 4),
('44-S-303', 'Peugeot', '208', 'VF3303303303', 'Hybride', NULL); 

INSERT INTO TEST_CATALOG (nom_test, valeur_min, valeur_max, est_obligatoire, description) VALUES 
('Système de Freinage', 0.50, 1.00, TRUE, 'Efficacité globale du freinage'),
('Émission CO2', 0.00, 0.05, TRUE, 'Analyse des gaz échappement'),
('Éclairage Avant', 100, 500, TRUE, 'Intensité lumineuse (Lux)'),
('Suspension', 20.00, 80.00, TRUE, 'Efficacité des amortisseurs'),
('Pneumatiques', 1.60, 8.00, TRUE, 'Profondeur des rainures (mm)'),
('Batterie', 12.0, 14.8, FALSE, 'Tension de batterie au démarrage');

INSERT INTO RENDEZ_VOUS (date_rdv, heure_rdv, status, code_confirmation, id_vehicle) VALUES 
('2026-05-10', '09:00:00', 'termine', 'CONF001', 1),
('2026-05-12', '10:30:00', 'termine', 'CONF002', 3),
('2026-05-15', '14:00:00', 'confirme', 'CONF003', 2),
('2026-05-20', '11:00:00', 'en_attente', 'CONF004', 4),
('2026-05-01', '16:00:00', 'annule', 'CONF005', 5);

INSERT INTO RAPPORT (date_rapport, kilometrage, prix_total, resultat_final, id_rdv, id_inspector) VALUES 
('2026-05-10 10:15:00', 125000, 350.00, 'favorable', 1, 1),
('2026-05-12 11:45:00', 85000, 400.00, 'defavorable', 2, 2);


INSERT INTO INSPECTIONS (id_test, id_rapport, valeur_trouvee, etat_test) VALUES 
(1, 1, 0.85, 'valide'), 
(2, 1, 0.02, 'valide'),
(1, 2, 0.40, 'echec'),  
(4, 2, 15.0, 'echec');  
