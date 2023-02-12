CREATE TABLE users(id SERIAL PRIMARY KEY , firstname TEXT NOT NULL , lastname TEXT NOT NULL , email TEXT NOT NULL , password TEXT NOT NULL );
 

/*****crée un trigger pour chiffrer une chaîne de caractère de type Password *****/

CREATE FUNCTION public.users() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
	NEW.password = MD5(NEW.password);
	RETURN coalesce(NEW , OLD );
END;
$$;


CREATE TRIGGER PasswordTrigger BEFORE INSERT ON public.users FOR EACH ROW EXECUTE FUNCTION public.users();

INSERT INTO users(id , firstname , lastname , email, password ) values(1 , 'pierre' , 'jean', 'pierre.jean@gmail.com' , 'admin1234' );
INSERT INTO users(id , firstname , lastname , email, password ) values(2 , 'jean' , 'pierre', 'jean.pierre@gmail.com' , 'admin1234' );
INSERT INTO users(id , firstname , lastname , email, password ) values(3 , 'françois' , 'jean' ,'françois.jean@gmail.com', 'admin1234');
INSERT INTO users(id , firstname , lastname , email, password ) values(4 , 'louis' , 'francois' , 'louis.francois@gmail.com', 'admin1234');
INSERT INTO users(id , firstname , lastname , email, password ) values(5 , 'jaques' , 'louis' , 'jaques.louis@gmail.com', 'admin1234');
INSERT INTO users(id , firstname , lastname , email, password ) values(6 , 'denis' , 'jaques', 'denis.jaques@gmail.com' , 'admin1234');

DELETE FROM "users";

DROP FUNCTION public.users() CASCADE ;

DROP TABLE users;