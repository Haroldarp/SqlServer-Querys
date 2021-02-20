USE ECommerce

INSERT INTO ProductCategory VALUES ('Calzados', 'Parte de la indumentaria utilizada para proteger los pies'), 
('Camisas','Prenda de vestir tanto formal como informal de tela que cubre el torso y brazos, usualmente tiene mangas, cuello y botones en el frente'), 
('Blusas','Prenda de vestir femenina, generalmente de tela fina, que cubre el cuerpo hasta la cintura o cadera, con cuello y mangas, que suele ir abrochada por delante con botones'),
('Pantalones','Prenda de vestir que se ajusta a la cintura y llega a una altura variable de la pierna o hasta los tobillos, cubriendo cada pierna por separado'),
('Faldas','Prenda de vestir que cuelga de la cintura y cubre las piernas, al menos en parte'),
('Vestidos','Prendas utilizadas para cubrir el cuerpo'),
('Accesorios','Aquello que es secundario, que depende de lo principal o que se le une por accidente, (Correas,gafas,pulseras,ect)');
GO

INSERT INTO Sex VALUES ('Masculino'), ('Femenino');
GO

INSERT INTO Client (FirstName, LastName, Phone, Address, Mail, Sex, Birthdate) VALUES 
('Harold', 'Rodriguez', '8095994464', 'Mi casa', 'Harold@gmail.com',1, DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 24920), '1950-01-01')),
('Maria', 'Perez', '8095994465', 'su casa', 'Maria@gmail.com',2,DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 24920), '1950-01-01')),
('Juan', 'Fernandez', '8095994466', 'su casa', 'Juan@gmail.com',1,DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 24920), '1950-01-01')),
('Axel', 'Soto', '8095994467', 'su casa', 'Axel@gmail.com',1,DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 24920), '1950-01-01')),
('Miguel', 'Cordero', '8095994468', 'su casa', 'Miguel@gmail.com',1,DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 24920), '1950-01-01')),
('Ronald', 'Minaya', '8095994469', 'su casa', 'Ronald@gmail.com',1,DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 24920), '1950-01-01')),
('Yorky', 'Fannini', '8095994470', 'su casa', 'Yorky@gmail.com',2,DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 24920), '1950-01-01')),
('Aneury', 'Paniagua', '8095994471', 'su casa', 'Aneury@gmail.com',1,DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 24920), '1950-01-01')),
('Vianney', 'Tavares', '8095994472', 'su casa', 'Vianney@gmail.com',2,DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 24920), '1950-01-01')),
('Arlyn', 'Rodriguez', '8095994472', 'su casa', 'Arlyn@gmail.com',2,DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 24920), '1950-01-01')),
('Cliente1', 'Apellido1', '8095994473', 'su casa', 'Cliente1@gmail.com',1,DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 24920), '1950-01-01')),
('Cliente2', 'Apellido2', '8095994474', 'su casa', 'Cliente2@gmail.com',1,DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 24920), '1950-01-01')),
('Cliente3', 'Apellido3', '8095994475', 'su casa', 'Cliente3@gmail.com',1,DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 24920), '1950-01-01')),
('Cliente4', 'Apellido4', '8095994476', 'su casa', 'Cliente4@gmail.com',1,DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 24920), '1950-01-01')),
('Cliente5', 'Apellido5', '8095994477', 'su casa', 'Cliente5@gmail.com',1,DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 24920), '1950-01-01')),
('Cliente6', 'Apellido6', '8095994478', 'su casa', 'Cliente6@gmail.com',2,DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 24920), '1950-01-01')),
('Cliente7', 'Apellido7', '8095994479', 'su casa', 'Cliente7@gmail.com',2,DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 24920), '1950-01-01')),
('Cliente8', 'Apellido8', '8095994480', 'su casa', 'Cliente8@gmail.com',2,DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 24920), '1950-01-01')),
('Cliente9', 'Apellido9', '8095994481', 'su casa', 'Cliente9@gmail.com',2,DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 24920), '1950-01-01')),
('Cliente10', 'Apellido10', '8095994482', 'su casa', 'Cliente10@gmail.com',2,DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 24920), '1950-01-01'));
GO

INSERT INTO Product VALUES 
('Adidas Cloudfoam Pure', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 1),
('Skechers Go Walk Joy', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 1),
('Skechers Go Walk Lite-15430', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 1),
('adidas Grand Court', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 1),
('New Balance NERGIZE', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 1),
('Bulwark Nomex IIIA', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 2),
('Dickies - Camiseta de trabajo', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 2),
('Van Heusen - Camisa de vestir', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 2),
('Gentlemens Collection - Camisas de esmoquin', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 2),
('Maks NanTex Henley - Camiseta de manga larga', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 2),
('Calvin Klein Cami sin mangas', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 3),
('Hanes Cool DRI playera estilo polo', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 3),
('Hanes camiseta manga larga', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 3),
('French Toast Little Girls', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 3),
('Astylish blusas con cuello en V', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 3),
('Wrangler Authentics – Jeans clásicos', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 4),
('Wrangler Pantalones vaqueros clásicos', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 4),
('Levis 505', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 4),
('Gloria Vanderbilt - Pantalón de mezclilla', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 4),
('Democracy Womens Ab Solution Straight Leg Jean', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 4),
('French Toast Falda plisada para niña', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 5),
('Hoerev Falda de la escuela', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 5),
('Arjungo - Mini falda de volantes plisada', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 5),
('Tandisk - Falda acampanada plisada', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 5),
('Urban CoCo', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 5),
('ECOWISH - Vestido de mujer bohemio', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 6),
('Relipop - Vestido corto de verano', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 6),
('ZAFUL Vestido de playa sin mangas', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 6),
('OUGES - Vestido de verano de manga corta', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 6),
('uguest - Vestido de manga larga con cuello en V', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 6),
('Alain Mikli RX Marcos', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 7),
('COASION Kids Blue Light Blocking Glasses', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 7),
('Prada TRIANGLE PR11RV', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 7),
('Ray-Ban RX7159', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 7),
('Ray-Ban RX5154', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 7),
('Timberland - Cinturón de piel clásico', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 7),
('Dickies - Cinturón de piel', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 7),
('Swarovski - Pulsera con nudo infinito', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 7),
('PANDORA Jewelry Moments Slider', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 7),
('Pulsera PANDORA Reflexions', FLOOR(RAND()*(500-150+1))+10, ROUND((RAND()*(150-10)+10), 2)  , 'Description', 7);
GO





