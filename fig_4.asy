import pad_layout;

include "style.asy";

//----------------------------------------------------------------------------------------------------

pen p_bump_pl10 = black;
pen p_bump_pl5 = red;
pen p_bump2 = blue;
pen p_dip = heavygreen;

pen p_mid1 = red+dashed;
pen p_bump = blue+dashed;
pen p_mid2 = black+dashed;
pen p_dip2 = heavygreen+dashed;

//----------------------------------------------------------------------------------------------------

pen p;
real sh = 0;
real sc = 1.;

void DrawPoint(real sqrt_s, real v, real u, string type="")
{
	pen p_point = p + solid;

	if (type == "")
		draw(Scale((sqrt_s, sc*(v + sh))), mCi+2pt+p_point);
	if (type == "inf")
		draw(Scale((sqrt_s, sc*(v + sh))), mCi+false+2pt+p_point);
	if (type == "ext")
		draw(Scale((sqrt_s, sc*(v + sh))), mSt+3pt+p_point);

	draw(Scale((sqrt_s, sc*(v + sh-u)))--Scale((sqrt_s, sc*(v + sh+u))), p_point);
}

//----------------------------------------------------------------------------------------------------

void DrawTFit(real a, real b)
{
	guide g;
	for (real sqrt_s = 1.; sqrt_s <= 14.; sqrt_s += 0.1)
	{
		g = g--Scale((sqrt_s, a*log(sqrt_s) + b + sh));
	}
	draw(g, p);
}

//----------------------------------------------------------------------------------------------------

void DrawSFit(real a, real b)
{
	guide g;
	for (real sqrt_s = 1.; sqrt_s <= 14.; sqrt_s += 0.1)
	{
		g = g--Scale((sqrt_s, sc * (a*sqrt_s + b + sh)));
	}
	draw(g, p);
}

//----------------------------------------------------------------------------------------------------

real x_lab = 10.5;

void Label(string l, real y, real r = 0)
{
	label(rotate(r) * Label(l), (x_lab, y), p);
}

//----------------------------------------------------------------------------------------------------

xTicksDef = LeftTicks(2., 1.);

//----------------------------------------------------------------------------------------------------

NewPad("$\sqrt s\ung{TeV}$", "$|t|\ung{GeV^2}$");

// bump+10
p = p_bump_pl10;
Label("bump+10", 0.347, -5);
DrawPoint(2.76, 0.4719, 0.01);
DrawPoint(7.00, 0.3977, 0.0035);
DrawPoint(8.00, 0.38965, 0.0064);
DrawPoint(13.00, 0.3604, 0.0039);
DrawTFit(-0.067594001042205, 0.531627156568288);
DrawPoint(1.96, 0.486140147142593, 0.009103328134492, "ext");

// bump+5
p = p_bump_pl5;
Label("bump+5", 0.413, -6);
DrawPoint(2.76, 0.5019, 0.01);
DrawPoint(7.00, 0.4199, 0.0039);
DrawPoint(8.00, 0.4152, 0.0065);
DrawPoint(13.00, 0.3801, 0.004);
DrawPoint(1.96, 0.517979343255533, 0.009390427618439, "ext");
DrawTFit(-0.073994651859738, 0.567773635274041);

// bump2 (dsdt-bump)
p = p_bump2;
Label("bump2", 0.46, -7);
DrawPoint(2.76, 0.5719, 0.01);
DrawPoint(7.00, 0.474, 0.0053);
DrawPoint(8.00, 0.4672, 0.0066);
DrawPoint(13.00, 0.4232, 0.0034);
DrawPoint(1.96, 0.596504072646106, 0.009801516571181, "ext");
DrawTFit(-0.092225333122309, 0.658566600863705);

// dip
p = p_dip;
Label("dip", 0.51, -7);
DrawPoint(2.76, 0.6124, 0.01);
DrawPoint(7.00, 0.5332, 0.0066);
DrawPoint(8.00, 0.52045, 0.0068);
DrawPoint(13.00, 0.4682, 0.0038);
DrawTFit(-0.096050391364721, 0.716196912812969);
DrawPoint(1.96, 0.651560332791308, 0.010339399250097, "ext");

// mid 1
p = p_mid1;
Label("mid1", 0.58, -9);
DrawPoint(2.76, 0.69225, 0.02);
DrawPoint(7.00, 0.5947, 0.007);
DrawPoint(8.00, 0.5744, 0.0135);
DrawPoint(13.00, 0.53605, 0.0038);
DrawPoint(1.96, 0.718039806233958, 0.016232148258169, "ext");
DrawTFit(-0.096468169034265, 0.782957527429382);

// bump
p = p_bump;
Label("bump", 0.68, -10);
DrawPoint(2.76, 0.8, 0.04, "inf");
DrawPoint(7.00, 0.70655, 0.0072);
DrawPoint(8.00, 0.715, 0.0249);
DrawPoint(13.00, 0.632, 0.0035);
DrawTFit(-0.120087657154661, 0.940334666306937);
DrawPoint(1.96, 0.859522341120077, 0.020610904129264, "ext");

// mid 2
p = p_mid2;
Label("mid2", 0.81, -8);
DrawPoint(7.00, 0.8156, 0.0076);
DrawPoint(8.00, 0.8264, 0.0321);
DrawPoint(13.00, 0.76845, 0.0053);
DrawPoint(1.96, 0.91503290799268, 0.025366543203122, "ext");
DrawTFit(-0.077412006789874, 0.96712689012453);

// dip2
p = p_dip2;
Label("dip2", 0.9, -5);
DrawPoint(7.00, 0.896533333333334, 0.0085);
DrawPoint(8.00, 0.917675, 0.031);
DrawPoint(13.00, 0.86279, 0.008);
DrawTFit(-0.056460487083662, 1.00799732310574);
DrawPoint(1.96, 0.97000255036621, 0.030409684526518, "ext");

label(expLabel, (13.5, 0.97), W, Fill(white));

label("(a)", (7.5, 0.97), O, Fill(white));

limits((1, 0.31), (14, 1.02), Crop);

//----------------------------------------------------------------------------------------------------

NewPad("$\sqrt s\ung{TeV}$", "$\d\si/\d t\ung{mb/GeV^2}$");
scale(Linear, Log);

// bump+10
sh = 0;
sc = 1;
p = p_bump_pl10;
Label("bump+10", -0.55, 6.0);
DrawPoint(2.76, 0.0952, 0.012137923711864, "");
DrawPoint(7.00, 0.1333, 0.0237, "");
DrawPoint(8.00, 0.1903, 0.0157, "");
DrawPoint(13.00, 0.2575, 0.0162, "");
DrawPoint(1.96, 0.081432532995515, 0.012374378239514, "ext");
DrawSFit(0.016034165811511, 0.050005568004954);

// bump+5
sh = 0;
sc = 1;
p = p_bump_pl5;
Label("bump+5", -0.8, 6.0);
DrawPoint(2.76, 0.05655, 0.00658614424471);
DrawPoint(7.00, 0.0781, 0.01158827911411);
DrawPoint(8.00, 0.105, 0.00758657121859);
DrawPoint(13.00, 0.1502, 0.00708635773165);
DrawPoint(1.96, 0.047087898870369, 0.006539691761808, "ext");
DrawSFit(0.00921467242052, 0.029027140926149);

// bump2 (dsdt-bump)
sh = 0;
sc = 0.2;
p = p_bump2;
Label("bump2 ($\times 0.2$)", -2.22, 6.0);
DrawPoint(2.76, 0.0159, 0.001837470976);
DrawPoint(7.00, 0.0256, 0.002641364528);
DrawPoint(8.00, 0.02885, 0.002067154848);
DrawPoint(13.00, 0.0466, 0.001492945168);
DrawPoint(1.96, 0.012216117516359, 0.001762948479047, "ext");
DrawSFit(0.003047868976556, 0.006242294322309);

// dip
sh = 0.;
sc = 0.1;
p = p_dip;
Label("dip ($\times 0.1$)", -2.77, 6.0);
DrawPoint(2.76, 0.0085, 0.00191754, "");
DrawPoint(7.00, 0.0161, 0.00191754, "");
DrawPoint(8.00, 0.01465, 0.002205171, "");
DrawPoint(13.00, 0.0273, 0.001438155, "");
DrawPoint(1.96, 0.006242383288143, 0.001752766929662, "ext");
DrawSFit(0.001861516365722, 0.002593811211328);

// mid1
sh = 0.;
sc = 1.;
p = p_mid1;
Label("mid1", -1.6, 6.);
DrawPoint(2.76, 0.0143, 0.002803437);
DrawPoint(7.00, 0.0218, 0.002231307);
DrawPoint(8.00, 0.0234, 0.001315899);
DrawPoint(13.00, 0.0376, 0.001258686);
DrawPoint(1.96, 0.009497360274839, 0.002044236130094, "ext");
DrawSFit(0.002493316027603, 0.004610460860737);

// bump
sh = 0;
sc = 2.;
p = p_bump;
Label("bump ($\times 2$)", -1.24, 6.0);
DrawPoint(2.76, 0.0171, 0.002268651, "");
DrawPoint(7.00, 0.0269, 0.002222352, "");
DrawPoint(8.00, 0.031, 0.001203774, "");
DrawPoint(13.00, 0.0483, 0.001250073, "");
DrawPoint(1.96, 0.012356545717959, 0.001805343933962, "ext");
DrawSFit(0.003202002275074, 0.006080621258815);

// mid2
sh = 0;
sc = 0.1;
p = p_mid2;
Label("mid2 ($\times 0.1$)", -2.41, 6.0);
DrawPoint(2.76, 0.0143, 0.002803437, "inf");
DrawPoint(7.00, 0.0216, 0.0038);
DrawPoint(8.00, 0.0223, 0.002849469424296);
DrawPoint(13.00, 0.03765, 0.0021);
DrawPoint(1.96, 0.010803108592891, 0.002636778742504, "ext");
DrawSFit(0.002351561860671, 0.006194047345976);

// dip2
sh = 0;
sc = 0.5;
p = p_dip2;
Label("dip2 ($\times 0.5$)", -1.85, 6.0);
DrawPoint(2.76, 0.0085, 0.001433840535, "inf");
DrawPoint(7.00, 0.0158, 0.00224325, "");
DrawPoint(8.00, 0.015875, 0.00181979983712, "");
DrawPoint(13.00, 0.0269, 0.0011964, "");
DrawPoint(1.96, 0.006582518818512, 0.001400861254386, "ext");
DrawSFit(0.001808733173017, 0.003037401799399);

label(expLabel, (1.5, -0.5), E, Fill(white));

label("(b)", (7.5, -0.5), O, Fill(white));

limits((1, 4e-4), (14, 5e-1), Crop);

GShipout(hSkip=5mm);
