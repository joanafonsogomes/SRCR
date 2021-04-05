import random
from datetime import datetime, timedelta
import json
fases = [["2020-12-01","2021-03-31"],["2021-04-01","2021-08-31"]]
macho = ['Aarao', 'Abdenago', 'Abelamio', 'Abelardo', 'Abilio', 'Abraao', 'Abrao', 'Absalao', 'Acacio', 'Acilino', 'Acilio', 'Acursio', 'Adalberto', 'Adalsindo', 'Adalsino', 'Adamantino', 'Adao', 'Adelio', 'Adelindo', 'Adelino', 'Adelmo', 'Adeodato', 'Aderio', 'Aderito', 'Adilio', 'Adolfo', 'Adonilo', 'Adorino', 'Adriano', 'Adrualdo', 'Adruzilo', 'Afonsino', 'Afonso', 'Afranio', 'Africano', 'Agnelo', 'Agostinho', 'Aladino', 'Alamiro', 'Alano', 'Alao', 'Albano', 'Alberico', 'Alberto', 'Alcindo', 'Alcino', 'Aldo', 'Aldo', 'Aldonio', 'Alexandrino', 'Alexandro', 'Alexio', 'Alipio', 'Alirio', 'Alitio', 'Alito', 'Almiro', 'Aloisio', 'Altino', 'Alvarino', 'Alvario', 'Alvaro', 'Alvino', 'Amado', 'Amarildo', 'Amarilio', 'Amaro', 'Americo', 'Andreo', 'Anfilito', 'Anfiloco', 'Angelico', 'Angelo', 'Anielo', 'Anisio', 'Anolido', 'Anselmo', 'Antelmo', 'Antero', 'Antonelo', 'Antonio', 'Anunciacao', 'Aparicio', 'Apio', 'Apolinario', 'Apolo', 'Aprigio', 'Aquilino', 'Arao', 'Arcadio', 'Arcanjo', 'Arcelino', 'Arcelio', 'Arcilio', 'Argemiro', 'Argentino', 'Ariosto', 'Arisberto', 'Armandino', 'Armando', 'Armenio', 'Armindo', 'Arquiminio', 'Arquimino', 'Arsenio', 'Ascenso', 'Aselio', 'Assuncao', 'Atanasio', 'Atao', 'Aureo', 'Ausendo', 'Austrelino', 'Avelino', 'Aventino', 'Azelio', 'Baldomero', 'Banduino', 'Barao', 'Barcino', 'Basilio', 'Bastiao', 'Bebiano', 'Benedito', 'Benevenuto', 'Benicio', 'Bento', 'Berardo', 'Berilo', 'Bernardino', 'Bernardo', 'Bertino', 'Berto', 'Bertolino', 'Betino', 'Beto', 'Brandao', 'Braulio', 'Breno', 'Brigido', 'Briolanjo', 'Bruno', 'Caetano', 'Caico', 'Caio', 'Calisto', 'Candido', 'Canto', 'Carlo', 'Carmerio', 'Carminho', 'Carmo', 'Cassiano', 'Cassio', 'Castelino', 'Catarino', 'Cedrico', 'Celino', 'Celio', 'Celisio', 'Celsio', 'Celso', 'Celto', 'Cesario', 'Cesaro', 'Cicero', 'Cidalio', 'Cildo', 'Cilio', 'Cirilo', 'Ciro', 'Clarindo', 'Claudemiro', 'Claudiano', 'Claudio', 'Clelio', 'Clesio', 'Clicio', 'Clidio', 'Clorindo', 'Conceicao', 'Consolacao', 'Constancio', 'Consulino', 'Coralio', 'Corino', 'Corito', 'Corsino', 'Cristiano', 'Cristoforo', 'Cristovao', 'Cursino', 'Dacio', 'Dagoberto', 'Damiao', 'Danilo', 'Darcio', 'Dario', 'Dario', 'Decimo', 'Delcio', 'Delfino', 'Delio', 'Delmano', 'Delmiro', 'Demetrio', 'Deolindo', 'Dercio', 'Deusdedito', 'Diamantino', 'Didaco', 'Diego', 'Digno', 'Dilermando', 'Dino', 'Diocleciano', 'Dioclecio', 'Diogo', 'Dionisio', 'Dioniso', 'Dionisodoro', 'Dirio', 'Divo', 'Djalmo', 'Dominico', 'Domitilo', 'Donaldo', 'Donato', 'Donzilio', 'Doriclo', 'Dorindo', 'Dorino', 'Druso', 'Duilio', 'Dulcinio', 'Dunio', 'Durbalino', 'Durvalino', 'Eberardo', 'Edipo', 'Edmero', 'Edo', 'Eduardo', 'Eduartino', 'Eduino', 'Edvino', 'Egidio', 'Eladio', 'Eleuterio', 'Eliano', 'Elio', 'Elisiario', 'Elmano', 'Elpidio', 'Elsio', 'Elvino', 'Elzeario', 'Elzo', 'Emidio', 'Emo', 'Encarnacao', 'Engracio', 'Enio', 'Enzo', 'Ercilio', 'Erico', 'Erico', 'Ermiterio', 'Esmeraldo', 'Estefano', 'Estelio', 'Estevao', 'Eudo', 'Eulogio', 'Eurico', 'Eustacio', 'Evaldo', 'Evandro', 'Evangelino', 'Evelacio', 'Evelasio', 'Evelio', 'Evencio', 'Everaldo', 'Everardo', 'Expedito', 'Fabiano', 'Fabiao', 'Fabio', 'Fabricio', 'Falco', 'Faustino', 'Fausto', 'Felicissimo', 'Ferdinando', 'Fernandino', 'Fernando', 'Fernao', 'Fidelio', 'Filino', 'Filinto', 'Filipo', 'Filomeno', 'Firmino', 'Firmo', 'Flavio', 'Florentino', 'Francisco', 'Franco', 'Franklino', 'Frederico', 'Fredo', 'Fulvio', 'Gabinio', 'Gabino', 'Galiano', 'Garibaldo', 'Gastao', 'Gavio', 'Gedeao', 'Genesio', 'Georgino', 'Geraldino', 'Geraldo', 'Gerberto', 'Germano', 'Gersao', 'Gervasio', 'Gildasio', 'Gildo', 'Gilmeno', 'Gino', 'Goncalo', 'Graciano', 'Graciliano', 'Gracio', 'Gregorio', 'Guido', 'Gumersindo', 'Gumesindo', 'Gusmao', 'Gustavo', 'Haraldo', 'Haroldo', 'Heladio', 'Heldemaro', 'Heldo', 'Helenico', 'Heleno', 'Helio', 'Heliodoro', 'Helvecio', 'Helvio', 'Hemeterio', 'Hemiterio', 'Heraldo', 'Herberto', 'Herculano', 'Heredio', 'Herenio', 'Heriberto', 'Hermano', 'Hermenegildo', 'Hermenerico', 'Herminio', 'Hermiterio', 'Hersilio', 'Higino', 'Hilario', 'Hildeberto', 'Hildebrando', 'Hildegardo', 'Hipolito', 'Hirondino', 'Homero', 'Honorato', 'Honorino', 'Horacio', 'Hortensio', 'Hugo', 'Iago', 'Iberico', 'Icaro', 'Idalio', 'Idario', 'Idelso', 'Ildo', 'Ilidio', 'Indalecio', 'Indro', 'Ingo', 'Inocencio', 'Io', 'Irmino', 'Isandro', 'Isauro', 'Isidoro', 'Isidro', 'Isildo', 'Isolino', 'Italo', 'Ivo', 'Izalino', 'Jaco', 'Jairo', 'Janardo', 'Jansenio', 'Januario', 'Jasao', 'Jeronimo', 'Jesualdo', 'Jetro', 'Jo', 'Joao', 'Jocelino', 'Jociano', 'Jordano', 'Jordao', 'Jorio', 'Joscelino', 'Josefo', 'Joselindo', 'Joselino', 'Josselino', 'Jovelino', 'Jovito', 'Juliano', 'Juliao', 'Julio', 'Junio', 'Juno', 'Juventino', 'Laercio', 'Laureano', 'Laurenio', 'Laurentino', 'Lauriano', 'Lauro', 'Lazaro', 'Leao', 'Leandro', 'Leccio', 'Lecio', 'Lenio', 'Leo', 'Leoberto', 'Leonardo', 'Leoncio', 'Leonicio', 'Leonidio', 'Libertario', 'Liberto', 'Liciniano', 'Licinio', 'Licio', 'Lidio', 'Lidorio', 'Ligio', 'Liliano', 'Lindorfo', 'Lindoro', 'Lino', 'Lisandro', 'Lito', 'Lopo', 'Lorenzo', 'Lourenco', 'Lucilio', 'Lucinio', 'Lucio', 'Ludgero', 'Ludovico', 'Ludovino', 'Lutero', 'Luzio', 'Marcio', 'Marco', 'Marcelo', 'Mariano', 'Mario', 'Martinho', 'Mauricio', 'Mauro', 'Maximo', 'Maximiliano', 'Maximino', 'Merrelho', 'Murilo', 'Napoleao', 'Nivaldo', 'Norberto', 'Normando', 'Nuno', 'Otavio', 'Olavo', 'Olivio', 'Ordonho', 'Orlando', 'Osorio', 'Osvaldo', 'Ovidio', 'Palmiro', 'Parcidio', 'Patricio', 'Paulino', 'Paulo', 'Paulino', 'Pedro', 'Pepio', 'Placido', 'Plinio', 'Polibio', 'Porfirio', 'Priao', 'Quiliano', 'Quintino', 'Quirilo', 'Quirino', 'Quirio', 'Quiterio', 'Rafaelo', 'Ramao', 'Ramiro', 'Raimundo', 'Reginaldo', 'Reinaldo', 'Remo', 'Renato', 'Ricardo', 'Roberto', 'Rodolfo', 'Rodrigo', 'Rogerio', 'Romao', 'Romano', 'Romulo', 'Ronaldo', 'Rosario', 'Sabino', 'Sacramento', 'Salemo', 'Salomao', 'Salustiano', 'Salustiniano', 'Salvacao', 'Salviano', 'Samaritano', 'Sancho', 'Sandrino', 'Sandro', 'Sansao', 'Santelmo', 'Santiago', 'Sario', 'Satiro', 'Saulo', 'Sauro', 'Savio', 'Sebastiao', 'Secundino', 'Segismundo', 'Selesio', 'Seleso', 'Selmo', 'Senio', 'Sergio', 'Sesinando', 'Severiano', 'Severino', 'Sidonio', 'Sifredo', 'Silvano', 'Silverio', 'Silviano', 'Silvio', 'Simao', 'Simauro', 'Simeao', 'Simplicio', 'Sindulfo', 'Sinesio', 'Sisenando', 'Sisinio', 'Sisnando', 'Sivio', 'Socorro', 'Soeiro', 'Solano', 'Sotero', 'SusanaFrancisco', 'Susano', 'Taciano', 'Tacio', 'Talio', 'Tarcisio', 'Tarsicio', 'Tasso', 'Tatiano', 'Teliano', 'Telmo', 'Telo', 'Teodemiro', 'Teodomiro', 'Teodoro', 'Teofilo', 'Tercio', 'Tiago', 'Tiberio', 'Tiburcio', 'Ticiano', 'Timoteo', 'Tirso', 'Tito', 'Toledo', 'Torcato', 'Torquato', 'Trajano', 'Tristao', 'Tulio', 'Turgo', 'Ubaldino', 'Ubaldo', 'Udo', 'Uldarico', 'Uldrico', 'Ulpiano', 'Ulpio', 'Ulfrido', 'Ulrico', 'Umbelino', 'Uranio', 'Urbalino', 'Urbino', 'Ursacio', 'Ursanio', 'Ursiao', 'Ursicio', 'Ursicino', 'Urso', 'Ursulino', 'Ursulo', 'Valerio', 'Vasco', 'Verissimo', 'Vidalio', 'Vinicio', 'Virgilio', 'Virginio', 'Virgulino', 'Viriato', 'Vitaliano', 'Vitalio', 'Vito', 'Vitorio', 'Vivaldo', 'Vladimiro', 'Xenio', 'Xico', 'Xisto', 'Zaido', 'Zairo', 'Zarco', 'Zelio']
femea = ['Abna', 'Acucena', 'Ada', 'Adalgisa', 'Adalia', 'Adelia', 'Adelina', 'Adila', 'Adilia', 'Adosinda', 'Adriana', 'Afonsina', 'Afra', 'Africana', 'Agata', 'Agna', 'Agueda', 'Aida', 'Airiza', 'Aisha', 'Alana', 'Alba', 'Alberta', 'Albertina', 'Alcina', 'Aldara', 'Aldenora', 'Aldora', 'Alegria', 'Aleixa', 'Aleta', 'Alexa', 'Alexandra', 'Alexandrina', 'Alexia', 'Alexina', 'Alfreda', 'Alia', 'Aliana', 'Alica', 'Alicia', 'Alida', 'Alina', 'Alita', 'Alma', 'Almara', 'Almesinda', 'Almira', 'Altina', 'Alva', 'Alvarina', 'Alzira', 'Amalia', 'Amanda', 'Amandina', 'Amara', 'Amelia', 'Amelina', 'America', 'Amora', 'Amorina', 'Amorzinda', 'Ana', 'Anabela', 'Anaisa', 'Anaisa', 'Analdina', 'Analia', 'Analisa', 'Anania', 'Andrea', 'Andreia', 'Andreina', 'Andrelina', 'Andresa', 'Andria', 'Anesia', 'Angela', 'Angelica', 'Angelina', 'Angelita', 'Ania', 'Aniana', 'Anicia', 'Aniria', 'Anisia', 'Anita', 'Anquita', 'Anteia', 'Antera', 'Antonela', 'Antonia', 'Antonieta', 'Antonina', 'Anunciada', 'Anusca', 'Aparecida', 'Aquila', 'Aquila', 'Aquira', 'Arabela', 'Aradna', 'Argentina', 'Aria', 'Ariadna', 'Ariana', 'Arinda', 'Arlanda', 'Armandina', 'Armenia', 'Artemisa', 'Artemisia', 'Aruna', 'Asia', 'Assunta', 'Atila', 'Atina', 'Aura', 'Aurea', 'Aurelia', 'Aureliana', 'Auriana', 'Ausenda', 'Auta', 'Auxilia', 'Ava', 'Barbara', 'Barbora', 'Bartolina', 'Basilia', 'Basilissa', 'Batista', 'Beanina', 'Bebiana', 'Bela', 'Belina', 'Belinda', 'Belisa', 'Bendavida', 'Benedita', 'Benicia', 'Benigna', 'Benita', 'Benjamina', 'Benvinda', 'Berengaria', 'Bernardina', 'Bernia', 'Bertila', 'Bertina', 'Betania', 'Betia', 'Betina', 'Bia', 'Biana', 'Bianca', 'Bibiana', 'Bina', 'Bitia', 'Blandina', 'Blasia', 'Boavida', 'Branca', 'Brasia', 'Brazia', 'Brena', 'Brenda', 'Briana', 'Bricia', 'Brigida', 'Briosa', 'Brizida', 'Bruna', 'Cassia', 'Caetana', 'Caia', 'Calila', 'Camelia', 'Camila', 'Cania', 'Carela', 'Carina', 'Carisa', 'Carisia', 'Carissa', 'Carita', 'Carla', 'Carlinda', 'Carlota', 'Carmelia', 'Carmelina', 'Carmelinda', 'Carmelita', 'Carmezinda', 'Carmina', 'Carminda', 'Carmorinda', 'Carolina', 'Carsta', 'Cassandra', 'Cassia', 'Cassilda', 'Casta', 'Castelina', 'Castorina', 'Catalina', 'Catarina', 'Caterina', 'Catia', 'Catila', 'Catilina', 'Cecilia', 'Celia', 'Celina', 'Celinia', 'Celsa', 'Cesaltina', 'Cesaria', 'Cesarina', 'Cheila', 'Chema', 'Cidalia', 'Cidalina', 'Cidalisa', 'Cilia', 'Cinara', 'Cinara', 'Cinderela', 'Cinira', 'Cintia', 'Cipora', 'Ciria', 'Cirila', 'Cita', 'Cizina', 'Clara', 'Clarina', 'Clarinda', 'Clarinha', 'Claudemira', 'Claudia', 'Claudiana', 'Cleia', 'Clelia', 'Clemencia', 'Cleopatra', 'Clesia', 'Clicia', 'Climenia', 'Clivia', 'Clorinda', 'Concha', 'Constanca', 'Constancia', 'Cora', 'Coralia', 'Cordelia', 'Corina', 'Corita', 'Cremilda', 'Crestila', 'Crisalia', 'Crisalida', 'Crisanta', 'Cristela', 'Cristiana', 'Cristina', 'Cristolinda', 'Dacia', 'Daina', 'Dalia', 'Daliana', 'Dalida', 'Dalila', 'Dalinda', 'Dalva', 'Dana', 'Dania', 'Daniana', 'Dariana', 'Daniela', 'Danila', 'Dara', 'Darcilia', 'Darnela', 'Davina', 'Davinia', 'Debora', 'Decia', 'Dejanira', 'Delia', 'Deliana', 'Delisa', 'Delmina', 'Delmina', 'Delminda', 'Delmira', 'Demelza', 'Demetria', 'Denisa', 'Deodata', 'Deotila', 'Deotila', 'Derocila', 'Dhruva', 'Dialina', 'Diamantina', 'Diana', 'Didia', 'Didiana', 'Digna', 'Diliana', 'Dilsa', 'Dina', 'Dina', 'Dinarda', 'Dinarta', 'Dineia', 'Dinora', 'Dioclecia', 'Diocleciana', 'Dionisia', 'Dircea', 'Dircila', 'Disa', 'Ditza', 'Diva', 'Diza', 'Djalma', 'Djamila', 'Domitila', 'Domitilia', 'Donatila', 'Donzelia', 'Donzilia', 'Dora', 'Dorabela', 'Doriana', 'Dorina', 'Dorinda', 'Dorisa', 'Drusila', 'Duartina', 'Dulcelina', 'Dulcidia', 'Dulcina', 'Dulcineia', 'Dulia', 'Dunia', 'Durvalina', 'Eda', 'Ederia', 'Edina', 'Edma', 'Edna', 'Eduarda', 'Eduina', 'Eglantina', 'Elana', 'Elca', 'Elda', 'Electra', 'Eleia', 'Elena', 'Eleonora', 'Elia', 'Eliana', 'Elicia', 'Elina', 'Elisa', 'Elisabeta', 'Elisama', 'Eliseba', 'Elisia', 'Elma', 'Elmira', 'Eloa', 'Elodia', 'Elodia', 'Eloisa', 'Elsa', 'Elsinda', 'Eluina', 'Elva', 'Elvina', 'Elza', 'Ema', 'Emanuela', 'Emidia', 'Emilia', 'Emiliana', 'Engelecia', 'Enia', 'Enilda', 'Eola', 'Eponina', 'Ercilia', 'Erica', 'Erica', 'Erika', 'Ermeria', 'Esmeralda', 'Esmeria', 'Especiosa', 'Esperanca', 'Estefana', 'Estefania', 'Estela', 'Estrela', 'Etelca', 'Eteria', 'Eudora', 'Eufemia', 'Eularina', 'Eurica', 'Eutalia', 'Eva', 'Evandra', 'Evangelista', 'Evelina', 'Evila', 'Ezequiela', 'Fabia', 'Fabiana', 'Fabiola', 'Fabricia', 'Fania', 'Fantina', 'Fara', 'Farida', 'Fatima', 'Feba', 'Fedora', 'Fedra', 'Felicia', 'Feliciana', 'Felisbela', 'Felisbina', 'Felismina', 'Fernandina', 'Fiama', 'Fidelia', 'Filena', 'Filipa', 'Filomena', 'Fiona', 'Flaminia', 'Flavia', 'Flora', 'Florbela', 'Florenca', 'Florencia', 'Floria', 'Floriana', 'Florisa', 'Florisbela', 'Francilia', 'Francina', 'Francisca', 'Frederica', 'Gabinia', 'Gabriela', 'Gaela', 'Gaia', 'Gala', 'Galiana', 'Garcia', 'Gardela', 'Geisa', 'Genciana', 'Genesia', 'Georgeta', 'Georgia', 'Georgina', 'Geralda', 'Geraldina', 'Gerberta', 'Gerda', 'Germana', 'Gerta', 'Gervasia', 'Giana', 'Giulia', 'Gilberta', 'Gilda', 'Gilma', 'Gina', 'Gioconda', 'Giovana', 'Giraldina', 'Gisela', 'Giselda', 'Gislena', 'Glaucia', 'Glenda', 'Glicinia', 'Gloriosa', 'Goma', 'Goncala', 'Gonzaga', 'Graca', 'Gracia', 'Graciana', 'Graciela', 'Graciliana', 'Gracinda', 'Graciosa', 'Gravelina', 'Gregoria', 'Greta', 'Grimanesa', 'Guendolina', 'Guida', 'Guislena', 'Gumersinda', 'Hadassa', 'Halia', 'Harolda', 'Heda', 'Hedila', 'Helada', 'Heladia', 'Helda', 'Helena', 'Helga', 'Helia', 'Heliana', 'Heliodora', 'Heloisa', 'Helvecia', 'Helvia', 'Hemeteria', 'Hemiteria', 'Henriqueta', 'Heralda', 'Herberta', 'Herculana', 'Herenia', 'Heriberta', 'Hermana', 'Hermania', 'Hermenegilda', 'Hermenerica', 'Herminia', 'Hersilia', 'Higina', 'Hilaria', 'Hildeberta', 'Hildegarda', 'Hilma', 'Hipolita', 'Honorata', 'Honorina', 'Horacia', 'Hortensia', 'Hulda', 'Iana', 'Iara', 'Iasmina', 'Iberina', 'Ida', 'Idalia', 'Idalina', 'Idelia', 'Idilia', 'Igelcemina', 'Ilca', 'Ilda', 'Ilidia', 'Ilsa', 'Ima', 'Indaleta', 'India', 'Indira', 'Inga', 'Ingeburga', 'Inocencia', 'Iolanda', 'Ionara', 'Iracema', 'Ireneia', 'Iria', 'Iriana', 'Irina', 'Irisalva', 'Irma', 'Isa', 'Isabela', 'Isabelina', 'Isadora', 'Isalda', 'Isalia', 'Isalina', 'Isaura', 'Isaurinda', 'Isilda', 'Ismalia', 'Isolda', 'Isolina', 'Iva', 'Ivana', 'Ivania', 'Ivanoela', 'Jacira', 'Jacobina', 'Jalmira', 'Jamila', 'Jamilia', 'Janaina', 'Jandira', 'Jania', 'Janina', 'Jaquelina', 'Jasmina', 'Jerusa', 'Jessica', 'Jitendra', 'Joana', 'Joaninha', 'Jocelina', 'Joela', 'Joelma', 'Jonata', 'Jordana', 'Jorgina', 'Jorja', 'Josana', 'Joscelina', 'Josefa', 'Josefa', 'Josefina', 'Joselia', 'Joselina', 'Josiana', 'Josina', 'Josivania', 'Josselina', 'Josuana', 'Jovelina', 'Juda', 'Juliana', 'Julinda', 'Julita', 'Juna', 'Junia', 'Jussara', 'Karina', 'Katarina', 'Katia', 'Kyara', 'Laila', 'Laira', 'Lana', 'Lara', 'Larissa', 'Laura', 'Laureana', 'Laurina', 'Laurinda', 'Lavinia', 'Lea', 'Leandra', 'Leena', 'Leila', 'Lelia', 'Lenia', 'Lenira', 'Leocadia', 'Leolina', 'Leomenia', 'Leonardina', 'Leonia', 'Leonida', 'Leonidia', 'Leonila', 'Leonilda', 'Leonilia', 'Leonisa', 'Leonora', 'Leontina', 'Leta', 'Leticia', 'Letizia', 'Levina', 'Lia', 'Liana', 'Liara', 'Liberalina', 'Liberia', 'Libertaria', 'Libia', 'Licia', 'Licinia', 'Lidia', 'Lidiana', 'Liduina', 'Ligia', 'Lila', 'Lila', 'Lilia', 'Liliana', 'Lina', 'Linda', 'Lineia', 'Lira', 'Lisa', 'Lisana', 'Lisandra', 'Lisdalia', 'Liseta', 'Livia', 'Lizelia', 'Loela', 'Lolia', 'Loredana', 'Lorena', 'Loreta', 'Lorina', 'Lourenca', 'Lua', 'Luana', 'Lubelia', 'Luca', 'Lucelia', 'Lucelinda', 'Lucena', 'Lucia', 'Lucialina', 'Luciana', 'Lucilia', 'Lucilina', 'Lucina', 'Luciola', 'Ludmila', 'Luela', 'Luena', 'Luisa', 'Lumena', 'Luna', 'Lusa', 'Lussinga', 'Lutgarda', 'Luzia', 'Luzinira', 'Madalena', 'Mafalda', 'Magda', 'Manuela', 'Mara', 'Marcia', 'Margarida', 'Marcela', 'Marcolina', 'Margarida', 'Maria', 'Mariana', 'Marilda', 'Marilia', 'Marina', 'Marisa', 'Marta', 'Maura', 'Maxima', 'Mecia', 'Melania', 'Melinda', 'Melissa', 'Miguelina', 'Milena', 'Micaela', 'Minervina', 'Monica', 'Morgana', 'Nadia', 'Natacha', 'Natalia', 'Natalina', 'Natercia', 'Neusa', 'Neuza', 'Nelia', 'Nidia', 'Nilza', 'Nina', 'Noa', 'Noemia', 'Nuria', 'Otavia', 'Odilia', 'Ofelia', 'Olivia', 'Oliveira', 'Olga', 'Ondina', 'Oriana', 'Otilia', 'Paloma', 'Palmira', 'Pandora', 'Poliana', 'Patricia', 'Paulina', 'Paula', 'Petra', 'Priscila', 'Quaiela', 'Quelia', 'Quezia', 'Quirina', 'Quiteria', 'Rafaela', 'Rebeca', 'Regina', 'Renata', 'Ricardina', 'Rita', 'Roberta', 'Roquita', 'Rosa', 'Rosalia', 'Rosalina', 'Rosalinda', 'Rosana', 'Rossana', 'Rosaura', 'Ruca', 'Sabina', 'Sabrina', 'Safia', 'Safira', 'Salima', 'Salma', 'Saluquia', 'Salvina', 'Samanta', 'Samara', 'Samaritana', 'Samira', 'Sancha', 'Sancia', 'Sandra', 'Sandrina', 'Santana', 'Sara', 'Sarina', 'Sasquia', 'Sassia', 'Satia', 'Satira', 'Saula', 'Saulina', 'Sebastiana', 'Sefora', 'Selena', 'Selenia', 'Selesa', 'Selesia', 'Selma', 'Sena', 'Senia', 'Seomara', 'Serafina', 'Serena', 'Serenela', 'Sesira', 'Sextina', 'Sheila', 'Sibila', 'Siddartha', 'Siena', 'Silvana', 'Silvandira', 'Silvia', 'Silvia', 'Silviana', 'Simara', 'Simaura', 'Simoneta', 'Sira', 'Siria', 'Sirla', 'Sofia', 'Solana', 'Solongia', 'Sonia', 'Soraia', 'Stela', 'Stelina', 'Sulamita', 'Sunamita', 'Suria', 'Susana', 'SusanaIlidia', 'Tabita', 'Taciana', 'Taisa', 'Taissa', 'Talia', 'Talita', 'Tamara', 'Tanagra', 'Tania', 'Tarina', 'Tasia', 'Tatiana', 'Tejala', 'Telma', 'Teodora', 'Teresa', 'Teresca', 'Teresina', 'Teresinha', 'Terezinha', 'Tiana', 'Tiara', 'Ticiana', 'Tirsa', 'Tirza', 'Tita', 'Titania', 'Torpecia', 'Traciana', 'Trasila', 'Tulipa', 'Ulpia', 'Ulpiana', 'Ulfrida', 'Ulrica', 'Umbelina', 'Urania', 'Urbalina', 'Urbanila', 'Urbina', 'Urbiria', 'Urraca', 'Ursa', 'Ursicia', 'Ursiciana', 'Ursula', 'Ursulina', 'Valentina', 'Valeria', 'Vanda', 'Vanessa', 'Vania', 'Vera', 'Veronica', 'Vestina', 'Vicencia', 'Vicenta', 'Victoria', 'Vida', 'Vilma', 'Vinicia', 'Violeta', 'Violinda', 'Vitalia', 'Vitiza', 'Vitoria', 'Vivalda', 'Vivelinda', 'Viviana', 'Vivina', 'Welwitschia', 'Xenia', 'Xica', 'Ximena', 'Yara', 'Yolanda', 'Zahra', 'Zaida', 'Zaira', 'Zara', 'Zara', 'Zarina', 'Zeferina', 'Zelia', 'Zelinda', 'Zena', 'Zenaida', 'Zenia', 'Zera', 'Zila', 'Zilda', 'Zilia', 'Zilma', 'Zita', 'Ziza', 'Zoa', 'Zobaida', 'Zola', 'Zora', 'Zoraida', 'Zubaida', 'Zubeida', 'Zulaia', 'Zuleica']
other = ['Abdul', 'Abel', 'Abigail', 'Abraim', 'Acil', 'Adail', 'Adamastor', 'Adelaide', 'Ademar', 'Adiel', 'Adner', 'Adonai', 'Adonias', 'Adonis', 'Adriel', 'Adrien', 'Afre', 'Agenor', 'Agnes', 'Aide', 'Aires', 'Airton', 'Aitor', 'Alaide', 'Alan', 'Alcibiades', 'Alcides', 'Alcione', 'Aldair', 'Aldemar', 'Aldenir', 'Alder', 'Aleu', 'Alex', 'Alexandre', 'Alexis', 'Alfeu', 'Alice', 'Aline', 'Alisande', 'Alison', 'Alivar', 'Alix', 'Alois', 'Alpoim', 'Alvarim', 'Amadeu', 'Amadis', 'Amador', 'Amarilis', 'Amauri', 'Amavel', 'Aminadabe', 'Amor', 'Amorim', 'Amos', 'Anabel', 'Anael', 'Anaice', 'Anaide', 'Anaim', 'Anair', 'Anais', 'Analice', 'Analide', 'Anamar', 'Ananias', 'Anas', 'Anatilde', 'Andre', 'Andreas', 'Andres', 'Aneide', 'Angel', 'Anuque', 'Aquil', 'Aquiles', 'Araci', 'Aramis', 'Ardingue', 'Ari', 'Ariadne', 'Ariane', 'Ariel', 'Ariele', 'Arine', 'Aristides', 'Aristoteles', 'Arlete', 'Armelim', 'Aron', 'Arquimedes', 'Artur', 'Ary', 'Aser', 'Assis', 'Astrid', 'Astride', 'Ataide', 'Atenais', 'Aubri', 'Audete', 'Aurete', 'Axel', 'Aziz', 'Azuil', 'Baldemar', 'Baltasar', 'Baqui', 'Barac', 'Bartolomeu', 'Beatriz', 'Belchior', 'Belem', 'Benilde', 'Benjamim', 'Bernadete', 'Bernardete', 'Bernardim', 'Bertilde', 'Betsabe', 'Bianor', 'Bibili', 'Bijal', 'Boanerges', 'Boris', 'Bras', 'Brian', 'Brigite', 'Brites', 'Bruce', 'Brunilde', 'Bryan', 'Cael', 'Caleb', 'Candice', 'Caren', 'Carin', 'Carlos', 'Carmen', 'Carmim', 'Carol', 'Carole', 'Castor', 'Ceres', 'Chantal', 'Charbel', 'Chloe', 'Cibele', 'Cid', 'Circe', 'Clarisse', 'Cleide', 'Cleodice', 'Cleonice', 'Clife', 'Cloe', 'Cloe', 'Clovis', 'Colete', 'Cosete', 'Cosme', 'Cremilde', 'Crisante', 'Crispim', 'Cristele', 'Cristene', 'Cristofe', 'Dafne', 'Dagmar', 'Daisi', 'Damaris', 'Damas', 'Damien', 'Daniel', 'Dante', 'Darlene', 'Darque', 'Davi', 'David', 'Davide', 'Deise', 'Deivid', 'Dejalme', 'Dele', 'Delfim', 'Delmar', 'Demeter', 'Dener', 'Denil', 'Denis', 'Denise', 'Deodete', 'Deonilde', 'Dieter', 'Dilan', 'Dimas', 'Dinamene', 'Dinarte', 'Dinis', 'Diomar', 'Dione', 'Dionilde', 'Dirce', 'Dirque', 'Djalme', 'Dolique', 'Dolores', 'Domingas', 'Domingos', 'Doralice', 'Dorine', 'Doris', 'Dositeu', 'Duarte', 'Dulce', 'Durval', 'Earine', 'Eder', 'Eder', 'Edgar', 'Edi', 'Edine', 'Edir', 'Edite', 'Edith', 'Edmur', 'Egil', 'Eleazar', 'Eleine', 'Eleonor', 'Elgar', 'Eli', 'Eliab', 'Eliane', 'Elias', 'Eliete', 'Eliezer', 'Elin', 'Eline', 'Elioenai', 'Elisabete', 'Elisabeth', 'Elisete', 'Eliseu', 'Elmar', 'Elmer', 'Eloi', 'Elson', 'Elton', 'Emanuel', 'Emaus', 'Eneias', 'Enes', 'Enide', 'Enoque', 'Enrique', 'Eric', 'Erik', 'Erique', 'Eris', 'Ernani', 'Esau', 'Estanislau', 'Ester', 'Etel', 'Etel', 'Eunice', 'Euridice', 'Eveline', 'Ezequiel', 'Fani', 'Febe', 'Felicidade', 'Felix', 'Feliz', 'Ferrer', 'Filemon', 'Filipe', 'Filoteu', 'Flor', 'Floripes', 'Florival', 'Fradique', 'Franclim', 'Franklim', 'Franklin', 'Fred', 'Frede', 'Gabi', 'Gabriel', 'Gaele', 'Gail', 'Galileu', 'Gamaliel', 'Gaori', 'Gaorii', 'Gaspar', 'Gentil', 'Georgete', 'Gerson', 'Gertrudes', 'Giani', 'Gil', 'Gileade', 'Ginestal', 'Giovani', 'Girel', 'Gisete', 'Gislene', 'Gomes', 'Goreti', 'Graciete', 'Guadalupe', 'Gualdim', 'Gualter', 'Gueir', 'Gui', 'Guilherme', 'Guimar', 'Guislene', 'Guterre', 'Habacuc', 'Habacuque', 'Haide', 'Hamilton', 'Hazael', 'Hebe', 'Heber', 'Hedviges', 'Heitor', 'Helade', 'Helder', 'Heli', 'Helier', 'Helmut', 'Hemexi', 'Henoch', 'Henrique', 'Herlander', 'Herman', 'Hermes', 'Hernani', 'Herve', 'Holger', 'Hortense', 'Huguete', 'Iag', 'Ian', 'Ianis', 'Iasmin', 'iddy', 'Idavide', 'Idrisse', 'Ignez', 'Igor', 'Ilse', 'Ilundi', 'Ines', 'Infante', 'Ingrid', 'Ingride', 'Ingue', 'Inoi', 'Ione', 'Ioque', 'Irais', 'Irineu', 'Iris', 'Isaac', 'Isabel', 'Isac', 'Isael', 'Isai', 'Isaque', 'Isis', 'Ismael', 'Isolete', 'Israel', 'Iuri', 'Ivan', 'Ivanoel', 'Iven', 'Ivete', 'Ivone', 'Jabes', 'Jabim', 'Jacob', 'Jacome', 'Jacqueline', 'Jader', 'Jadir', 'Jael', 'Jaime', 'Jair', 'James', 'Jamim', 'Janai', 'Janete', 'Jani', 'Janice', 'Janine', 'Janique', 'Jaque', 'Jaqueline', 'Jaques', 'Jarbas', 'Jardel', 'Jasmim', 'Jeanete', 'Jeni', 'Jenifer', 'Jesse', 'Jesus', 'Jezabel', 'Jil', 'Joab', 'Joabe', 'Joaquim', 'Joas', 'Job', 'Joel', 'Joele', 'Jofre', 'Joice', 'Jonas', 'Jonatas', 'Joni', 'Joraci', 'Jorge', 'Josabete', 'Josafat', 'Jose', 'Joselene', 'Josete', 'Josiane', 'Josias', 'Josue', 'Judas', 'Juraci', 'Juvenal', 'Karen', 'Katie', 'Kelly', 'Kevin', 'kevin', 'Laertes', 'Lais', 'Laurine', 'Leal', 'Leanor', 'Lemuel', 'Leone', 'Leonel', 'Leonete', 'Leonilde', 'Leonor', 'Levi', 'Lhuzie', 'Liane', 'Lianor', 'Liberal', 'Liberdade', 'Lici', 'Licidas', 'Liete', 'Lilian', 'Liliane', 'Liliete', 'Lilite', 'Linete', 'Lineu', 'Linton', 'Lis', 'Lisete', 'Lisuarte', 'Liz', 'Lizi', 'Lizie', 'Loide', 'Lorine', 'Lorival', 'Lourival', 'Luamar', 'Lucas', 'Lucete', 'Lucileine', 'Luis', 'Luisete', 'Luizete', 'Lurdes', 'Lurdite', 'Luz', 'Lyannii', 'Lyonce', 'Magali', 'Mamede', 'Manel', 'Manuel', 'Marcilene', 'Marcos', 'Marlene', 'Marli', 'Martim', 'Mateus', 'Matias', 'Matilde', 'Melquisedeque', 'Mem', 'Mercedes', 'Miguel', 'Mileide', 'Milu', 'Micael', 'Michele', 'Miriam', 'Moacir', 'Moises', 'Miru', 'Nadine', 'Nair', 'Natividade', 'Nazare', 'Nelson', 'Nestor', 'Nicanor', 'Nicolas', 'Nicolau', 'Noah', 'Noe', 'Noel', 'Odete', 'Omar', 'Orestes', 'Oscar', 'Parias', 'Pascoal', 'Penelope', 'Piedade', 'Polibe', 'Quar', 'Queli', 'Querubim', 'Quevin', 'Quim', 'Rafael', 'Raquel', 'Raul', 'Reinamor', 'Renan', 'Roque', 'Roseli', 'Ruben', 'Rubim', 'Rudi', 'Rui', 'Rute', 'Sadi', 'Sadraque', 'Sadrudine', 'Salazar', 'Sales', 'Salete', 'Sali', 'Salome', 'Salomite', 'Salvador', 'Samir', 'Samuel', 'Sancler', 'Santos', 'Sarah', 'Sarai', 'Saul', 'Selene', 'Semiramis', 'Serafim', 'Sidnei', 'Sidraque', 'Silas', 'Silvestre', 'Simone', 'Socrates', 'Sol', 'Solange', 'Soledade', 'Solene', 'Suati', 'Sueli', 'Suraje', 'Surendralal', 'Suri', 'Suse', 'Susete', 'Susi', 'Tauane', 'Tadeu', 'Tais', 'Tamar', 'Tamar', 'Tamiris', 'Teseu', 'Tierri', 'Tobias', 'Tomas', 'Tome', 'Toni', 'Trindade', 'Tude', 'Ulisses', 'Ulfilas', 'Urias', 'Uriel', 'Urien', 'Uziel', 'Valdemar', 'Valentim', 'Valmor', 'Valter', 'Verter', 'Vianei', 'Vicente', 'Victor', 'Vidal', 'Vidaul', 'Vilar', 'Vilator', 'Vili', 'Vilmar', 'Vilson', 'Violante', 'Vital', 'Vitor', 'Viveque', 'Viviane', 'Vivilde', 'Wersun', 'Wilson', 'Xavier', 'Xenocrates', 'Xenon', 'Xerxes', 'Yasmin', 'Yuri', 'Zacarias', 'Zamy', 'Zaqueu', 'Zardilaque', 'Ze', 'Zenaide', 'Zoe', 'Zulmir']
doencas = ["Insuficiencia cardiaca","Doenca coronaria","Insuficiencia renal","Diabetes","Neoplasia maligna ativa","Doenca renal cronica","Insuficiencia hepatica","Hipertensao arterial","Obesidade"]
profissoes = ["Auxiliar de producao", "Auxiliar administrativo", "Advogado", "Administrador", "Advogado trabalhista", "Auditor fiscal", "Auxiliar de cozinha", "Agricultor", "Analista financeiro", "Assistente social", "Analista administrativo", "Assistente administrativo", "Arquiteto", "Assistente financeiro", "Assistente comercial", "Assistente de marketing", "Auxiliar de expedicao", "Agronomo", "Ator", "Assistente pessoal", "Arqueologo", "Analista de sistemas", "Auxiliar de limpeza", "Alfaiate", "Advogado criminalista", "Bancario", "Business partner", "Bartender", "Biologo", "Bombeiro", "Bioquimico", "Bombeiro civil", "Contabilista", "Cozinheiro", "Contador", "Confeiteiro", "Corretor de imoveis", "Consultor de vendas", "Cientista de dados", "Controller", "Cenografo", "Cabeleireiro", "Chefe de cozinha", "Comissario de bordo", "Carteiro", "Cerimonialista", "Coach", "Corretor de seguros", "Desembargador", "Designer de interiores", "Delegado", "Designer", "Diplomata", "DevOps", "DPO (Data protection officer)", "Desenvolvedor", "Despachante", "DBA (Administrador de Banco de Dados)", "Designer de moda", "Desenhista", "Empresario", "Esteticista", "Encanador", "Engenheiro mecanico", "Economista", "Estoquista", "Engenheiro de producao", "Editor de texto", "Engenheiro quimico", "Estilista", "Engenheiro civil", "Engenheiro de controle e automacao", "Engenheiro de materiais", "Engenheiro ambiental", "Eletricista", "Engenheiro agronomo", "Engenheiro eletrico", "Embaixador", "Engenheiro de software", "Engenheiro de alimentos", "Fotografo", "Fuzileiro naval", "Farmaceutico", "Figurinista", "Filosofo", "Geriatra", "Gestor ambiental", "Geografo", "Headhunter", "Interprete de libras", "Jornalista", "Jovem Aprendiz", "Juiz", "Militar", "Mestre cervejeiro", "Marinheiro", "Massoterapeuta", "Mecanico de carro", "Motorista", "Maestro", "Operador de caixa", "Oficial de Justica", "Operador de telemarketing", "Profissional de help desk", "Profissional de Facilities", "Profissional de Saude", "Pizzaiolo", "Padeiro", "Piloto de aviao", "Promotor de justica", "Personal trainer", "Perito criminal", "Profissional de Logistica", "Pedagogo", "Perito judicial", "Personal stylist", "Programador", "Produtor de video", "Professor", "Promotor de vendas", "Publicitario", "Profissional de Relacoes Publicas", "Profissional de Linguistica", "Policial militar", "Quimico", "Roteirizador", "Roteirista", "Recepcionista", "Radialista", "Reporter", "Representante comercial", "Social Media", "Tecnico em Seguranca do Trabalho", "Trader", "Tecnico em Radiologia", "Terapeuta ocupacional", "Torneiro mecanico", "Turismologo", "Teologo", "Taquigrafo", "Tecnico em edificacoes", "Tecnico em informatica", "Vigilante", "Veterinario", "Webmaster", "Web designer"]
centros = ["de Braga", "do Caranda", "do Cavado", "Dr.Paulo Novais"]
vacinas = ["Pfizer","Astrazeneca","Sputnik V","Moderna"]
moradas= []


def age(date):
    today = datetime.today()
    years = today.year - date.year
    if today.month < date.month or (today.month == date.month and today.day < date.day):
        years -= 1
    return years


with open("moradas.txt", 'r') as fh:
    for line in fh:
        line = line.rstrip("\n")
        moradas.append(line)


apelidos = json.loads(open('apelidos.json').read())

listaTelefones = []
listaIds = []
listaSeguranca = []

def geraTelefone(isPessoal):
    unico = False

    while not unico:
        tlm = ""
        if isPessoal:
            tlm = random.choice(["91","92","93","96"])
        else:
            tlm = random.choice(["21","22","23","24","25"])

        tlm+= geraNumero(7)

        unico = tlm not in listaTelefones

    listaTelefones.append(tlm)
    return tlm

def geraNumero(nums):
    res = ""
    while len(res) < nums:
        res += str(random.randint(0,9))
    return res

def geraNome(genero):
    if "M" in genero:
        return random.choice(random.choices([macho,other],weights=[10,1])[0])+ " " + random.choice(apelidos)
    else:
        return random.choice(random.choices([femea,other],weights=[10,1])[0])+ " " + random.choice(apelidos)

def genDoencas():
    listadoencas = []
    while random.randint(0,100) < 10:
        doenca = random.choice(doencas)
        if doenca not in listadoencas:
            listadoencas.append(doenca)
    return listadoencas


def genmail(name,anoNasc):

    nome,apelido = name.split(" ")
    odd = random.randint(0,100)
    if odd < 50:
        numero=""
    elif odd < 75:
        numero=str(anoNasc)
    else:
        numero = str(random.randint(0,400))


    mail = (nome + apelido + numero + random.choice(["@hotmail.com","@gmail.com","@outlook.com"]))

    return mail

def genUtente(id):
    utente = {}
    utente["genero"] = random.choice(["M","F"])
    utente["name"] = geraNome(utente["genero"])
    utente["id"] = "U" + str(id)
    nsoc = geraNumero(11)
    while nsoc in listaSeguranca:
        nsoc = geraNumero(11)
    utente["nSocial"] = nsoc
    listaSeguranca.append(nsoc)
    utente["dataNasc"] = (datetime.today() - timedelta(days = random.randint(3000,30000)))
    utente["email"] = genmail(utente["name"],utente["dataNasc"].year)
    utente["ntelefone"] = geraTelefone(True)
    utente["morada"] = random.choice(moradas)
    utente["profissao"] = random.choice(profissoes)
    utente["doencas"] = genDoencas()
    
    if(age(utente["dataNasc"]) >= 80 or "Insuficiência renal" in utente["doencas"] or "Doenca coronária" in utente["doencas"]):
        fase = datetime(2021,2,1) + timedelta(random.randint(1, 59))
    elif(age(utente["dataNasc"]) >= 65 or (age(utente["dataNasc"]) >= 50 and age(utente["dataNasc"]) <= 64 and ("Diabetes" in utente["doencas"] or "Neoplasia malgina ativa" in utente["doencas"] or "Doenca renal crónica" in utente["doencas"] or "Insuficiência hepática" in utente["doencas"] or "Hipertensão arterial" in utente["doencas"] or "Obesidade" in utente["doencas"] or "Quem gosta de redes" in utente["doencas"]))):
        fase = datetime(2021,4,1) + timedelta(random.randint(1, 59))
    else:
        fase = datetime(2021,6,1) + timedelta(random.randint(1, 59))
    
    utente["fases"] = [fase, fase + timedelta(days = random.randint(17,24))]
    utente["idCentro"] = "C" + str(random.randint(1, len(centros)))
    return utente

def genCentro(id):
    centro = {}
    centro["id"] = "C" + str(id+1)
    centro["name"] = "Centro de saúde " + centros[id]
    centro["morada"] = random.choice(moradas)
    centro["ntelefone"] = geraTelefone(False)
    centro["email"] = "suporte@{0}.com".format(centros[id].replace(".","").replace(" ","").lower())


    return centro

def genStaff(id):
    staff = {}
    staff["genero"] = random.choice(["M","F"])
    staff["name"] = geraNome(staff["genero"])
    staff["dataNasc"] = (datetime.today() - timedelta(days = random.randint(3000,30000)))
    staff["id"] = "S" + str(id)
    nsoc = geraNumero(11)
    while nsoc in listaSeguranca:
        nsoc = geraNumero(11)
    staff["nSocial"] = nsoc
    listaSeguranca.append(nsoc)
    staff["idLocal"] = "C" + str(random.randint(1, len(centros)))
    staff["email"] = genmail(staff["name"],staff["dataNasc"].year)

    return staff

def genVacinacoes():
    for utente in listaUtentes:
        vacina = random.choice(vacinas)
        vacinacao1 = {}
        staff = random.choice(listaStaff)
        while staff["idLocal"] != utente["idCentro"]:
            staff = random.choice(listaStaff)
        vacinacao1["idstaff"] = staff["id"]
        vacinacao1["idUtente"] = utente["id"]
        vacinacao1["tipo"] = random.choice(vacinas)
        vacinacao1["data"] = utente["fases"][0]
        vacinacao1["dose"] = 1
        vacinacao1["toma1"] = datetime.today() > vacinacao1["data"]
        vacinacao2 = {}
        vacinacao2["idstaff"] = vacinacao1["idstaff"]
        vacinacao2["idUtente"] = utente["id"]
        vacinacao2["tipo"] = vacinacao1["tipo"]
        vacinacao2["data"] = utente["fases"][1]
        vacinacao2["dose"] = 2
        vacinacao2["toma1"] = datetime.today() > vacinacao2["data"]
        listaVacinacoes.append(vacinacao1)
        listaVacinacoes.append(vacinacao2)






nUtentes = 100
nStaff = 20

listaUtentes = []
listaStaff = []
listaCentros = []
listaVacinacoes = []

for i in range(nUtentes):
    listaUtentes.append(genUtente(i))

for i in range(nStaff):
    listaStaff.append(genStaff(i))

for i in range(len(centros)):
    listaCentros.append(genCentro(i))

genVacinacoes()

with open('dataset.pl', 'a') as dataset:    
#converter utentes
    for utente in listaUtentes:
        #id nome nsoc genero data_nasc email tlm morada prof doencas fase1 fase2 idcentro
        dataset.write("utente('{0}','{1}','{2}','{3}','{4}','{5}',{6},'{7}','{8}',{9},'{10}').\n".format(utente["id"],
        utente["name"],
        utente["nSocial"],
        utente["genero"],
        utente["dataNasc"].date(),
        utente["email"],
        utente["ntelefone"],
        utente["morada"],
        utente["profissao"],
        str(utente["doencas"]),
        utente["idCentro"]))

    dataset.write("\n")
    for staff in listaStaff:
        #id nome nsoc email idcentro
        dataset.write("staff('{0}','{1}','{2}','{3}','{4}').\n".format(
        staff["id"],
        staff["name"],
        staff["nSocial"],
        staff["email"],
        staff["idLocal"]))

    dataset.write("\n")
    for centro in listaCentros:
        #id nome nsoc email idcentro
        dataset.write("centro('{0}','{1}','{2}','{3}','{4}').\n".format(
        centro["id"],
        centro["name"],
        centro["morada"],
        centro["ntelefone"],
        centro["email"]))

    dataset.write("\n")
    for vacinacao in listaVacinacoes:
        dataset.write("vacinacao('{0}','{1}','{2}','{3}',{4}).\n".format(
        vacinacao["idstaff"],
        vacinacao["idUtente"],
        vacinacao["data"].date(),
        vacinacao["tipo"],
        vacinacao["dose"]))

    dataset.write("\n")
    i=1
    for fase in fases:
        dataset.write("fase('{0}','{1}','{2}').\n".format("F"+str(i),fase[0],fase[1]))
        i+=1