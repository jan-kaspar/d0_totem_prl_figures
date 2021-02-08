import pad_layout;

include "style.asy";

ySizeDef = 4.3cm;

//----------------------------------------------------------------------------------------------------

pen p;
real sh = 0;

void DrawPoint(real sqrt_s, real v, real u, string type="")
{
	if (type == "") { p = black; draw(Scale((sqrt_s, v + sh)), mCi+2pt+p); }
	if (type == "inf"){ p = black; draw(Scale((sqrt_s, v + sh)), mCi+false+2pt+p); }
	if (type == "ext") { p = blue; draw(Scale((sqrt_s, v + sh)), mSt+3pt+p); }

	draw(Scale((sqrt_s, v + sh-u))--Scale((sqrt_s, v + sh+u)), p);
}

//----------------------------------------------------------------------------------------------------

void DrawSTotFit(real a, real b, real var_a=0, real var_b=0, real cov_ab=0)
{
	guide g;
	guide g, g_up, g_dw;
	for (real sqrt_s = 1.5; sqrt_s <= 14.; sqrt_s += 0.1)
	{
		real L = log(sqrt_s);

		g = g--Scale((sqrt_s, a*L*L + b + sh));

		real y = a*L*L + b + sh;
		real y_unc = sqrt(var_a * L*L*L*L + 2*cov_ab * L*L + var_b);

		g = g--Scale((sqrt_s, y));
		g_up = g_up--Scale((sqrt_s, y + y_unc));
		g_dw = g_dw--Scale((sqrt_s, y - y_unc));
	}

	draw(g_up, red+dashed);
	draw(g, red);
	draw(g_dw, red+dashed);
}

//----------------------------------------------------------------------------------------------------

real x_lab = 10.5;

void Label(string l, real y, real r = 0)
{
	label(rotate(r) * Label(l), (x_lab, y), p);
}

//----------------------------------------------------------------------------------------------------

xTicksDef = LeftTicks(2., 1.);

NewPad("$\sqrt s\ung{TeV}$", "$\si_{\rm tot}\ung{mb}$", yTicks = RightTicks(5., 1.));

// sigma_tot
sh = 0;
p = red;

DrawSTotFit(4.62742471763521, 80.640746143286, 5.195e-01, 1.127e+01, -2.249e+00);
DrawPoint(2.76, 84.7, 3.3);
DrawPoint(7.00, 98.0, 2.5);
DrawPoint(8.00, 101.5, 2.1);
DrawPoint(13.00, 110.5, 2.4);
DrawPoint(1.96, 82.7362951583186, 3.05572934173256, "ext");

label(expLabel, (1.2, 112.5), E, Fill(white));

limits((1, 75), (14., 115), Crop);

AddToLegend("TOTEM measurements", mCi+2pt+black);
AddToLegend("fit", red);
AddToLegend("$\pm 1\un{\si}$ fit uncertainty band", red+dashed);
AddToLegend("extrapolation", mSt+3pt+blue);
AttachLegend(shift(-5, +5) * BuildLegend(SE, lineLength=5mm, vSkip=-1mm, framePen=nullpen, xmargin=0mm, ymargin=0pt), SE);
