/*

	Based on the "No 'Player' Name" plugin by Vet(3TT3V)

*/

#include <amxmodx>
#include <fakemeta>

new g_playername[][] = {
	"Joetta Loyd",
	"Patty Burton",
	"Rachel Simmons",
	"Antonia Schultz",
	"Alberta Ball",
	"Angele Tharp",
	"Dixie Zimmerman",
	"Dale Castro",
	"Clara Griffin",
	"Alessandra Savoy",
	"Cary Baldwin",
	"Johnathon Calhoun",
	"Archie Nunez",
	"Renae Cho",
	"Taylor Carlson",
	"Garth Arevalo",
	"Sanjuanita Cabrera",
	"Brice Rosales",
	"Aretha Whitlow",
	"Jill Yates",
	"Rodney Vargas",
	"Traci Dixon",
	"Malcolm Byrd",
	"Lance Bryant",
	"Jenny Mcguire",
	"Ruben Warner",
	"Kristopher Gonzales",
	"Stephani Elrod",
	"Donald Flagg",
	"Berenice Mcneil",
	"Toby Rose",
	"Tina Fletcher",
	"Geoffrey Dean",
	"Terrance Burton",
	"Leonida Tobin",
	"Carroll Sanchez",
	"Marjorie Jennings",
	"Ismael Hanson",
	"Rachael Shaw",
	"Margarette Babcock",
	"Nora Moran",
	"Indira Steffen",
	"June Rios",
	"Gail Becker",
	"Danika Jorgenson",
	"Alberto Frank",
	"Emelina Peeler",
	"Iva Palma",
	"Cheree Valentine",
	"Lilliam Crouse",
	"Anthony Greene",
	"Sheri Alvarez",
	"Harris Contreras",
	"Pamula Maguire",
	"Boyce Cassidy",
	"Jimmy Boone",
	"Ethel Mullins",
	"Darryl Ortiz",
	"Maggie Rogers",
	"Susan Peters",
	"Olimpia Isaac",
	"Sheldon Harmon",
	"Willie Salazar",
	"Dustin Barber",
	"Erick Thomas",
	"Gina Hawkins",
	"Jacqulyn Nix",
	"Marivel Ellsworth",
	"Delia Sparks",
	"Lillie Webb",
	"Pauline Evans",
	"Epifania Hurt",
	"Conception Reddy",
	"Ivan Collins",
	"Adelina Foust",
	"Wade Roy",
	"Alfredia Salisbury",
	"Brian Salazar",
	"Norene Marx",
	"Krystal Simon",
	"Georgetta Peace",
	"Helen Butler",
	"Chantelle Dobson",
	"Arvilla Lear",
	"Loriann Steed",
	"Don Bowman",
	"Tommy Jennings",
	"Kimberly Doyle",
	"Kelli Crawford",
	"Gregoria Arriaga",
	"Jennifer Carroll",
	"Shannon Matthews",
	"Lonnie Hayes",
	"Haywood Gaither",
	"Autumn Schubert",
	"Nettie Thornton",
	"Martha Elliott",
	"Suzanne Sherman",
	"Noelle Whitmore",
	"Donya Carmichael"
}

new g_nameptr = 0

public plugin_init()
{
	register_plugin("No 'Player' Name", "1.0", "Fysiks")
	register_forward(FM_ClientUserInfoChanged, "fwClientUserInfoChanged")

	new nameptr[8]
	get_localinfo("NamePtr", nameptr, charsmax(nameptr))
	g_nameptr = str_to_num(nameptr)

	if( g_nameptr == 0 )
	{
		g_nameptr = random(sizeof(g_playername))
	}
}

public client_infochanged(id) // This changes a user's name to one of the predefined names
{
	static newname[32]
	get_user_info(id, "name", newname, charsmax(newname))
	if( equali(newname, "Player") )
	{
		set_player_name(id)
	}
}

public fwClientUserInfoChanged(id, buffer) // This prevent people from changing to the name "Player"
{
	if( !is_user_connected(id) || is_user_bot(id) || !is_user_alive(id) )
		return FMRES_IGNORED

	static name[32], val[32]
	get_user_name(id, name, charsmax(name))
	engfunc(EngFunc_InfoKeyValue, buffer, "name", val, charsmax(val))
	if( equal(val, name) )
		return FMRES_IGNORED

	trim(val)
	if( equali(val, "Player") )
	{
		engfunc(EngFunc_SetClientKeyValue, id, buffer, "name", name)
		console_print(id, "You may not use that name. Try Again.")
		return FMRES_SUPERCEDE
	}

	return FMRES_IGNORED
}

set_player_name(id)
{
	static n_name[16]
	set_user_info(id, "name", g_playername[g_nameptr])
	g_nameptr = ++g_nameptr % sizeof(g_playername)
	num_to_str(g_nameptr, n_name, charsmax(n_name))
	set_localinfo("NamePtr", n_name)
}
