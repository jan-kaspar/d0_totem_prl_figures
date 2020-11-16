import root;
import pad_layout;

include "style.asy";

//----------------------------------------------------------------------------------------------------

real dx = 1e-5;

//----------------------------------------------------------------------------------------------------

pair FindMin(RootObject fit, real x_min, real x_max)
{
	pair r = (-1e100, 1e100);

	for (real x = x_min; x <= x_max; x += dx)
	{
		real v = fit.rExec("Eval", x);

		if (v < r.y)
			r = (x, v);
	}

	return r;
}

//----------------------------------------------------------------------------------------------------

pair FindMax(RootObject fit, real x_min, real x_max)
{
	pair r = (-1e100, -1e100);

	for (real x = x_min; x <= x_max; x += dx)
	{
		real v = fit.rExec("Eval", x);

		if (v > r.y)
			r = (x, v);
	}

	return r;
}

//----------------------------------------------------------------------------------------------------

pair FindVal(RootObject fit, real vt, real x_min, real x_max)
{
	pair r = (-1e100, -1e100);

	real prev_diff = 1e100;

	for (real x = x_min; x <= x_max; x += dx)
	{
		real v = fit.rExec("Eval", x);

		real diff = abs(v - vt);

		if (diff < prev_diff)
		{
			r = (x, v);
			prev_diff = diff;
		}
	}

	return r;
}

//----------------------------------------------------------------------------------------------------

string f = "/afs/cern.ch/work/j/jkaspar/work/analyses/D0_TOTEM/fits/bootstrap/bootstrap/st+sy+no/do_fits.root";

drawGridDef = false;

NewPad("$|t|$", "$\d\si/\d t$");
currentpad.xTicks = LeftTicks("%");
currentpad.yTicks = RightTicks("%");
scale(Linear, Log);

TF1_x_min = 0.35;
TF1_x_max = 0.90;

RootObject fit = RootGetObject(f, "13TeV/f_fit");

draw(fit, blue+1pt);
//draw(RootGetObject(f, "13TeV/g_fit"), red+dashed);

pair p_dip = FindMin(fit, 0.45, 0.5);
pair p_bump = FindMax(fit, 0.6, 0.7);

real A = p_bump.y - p_dip.y;

pair p_bump_0 = FindVal(fit, p_bump.y, 0.38, 0.45);
pair p_bump_5 = FindVal(fit, p_bump.y + 5. * A, 0.30, 0.40);
pair p_bump_10 = FindVal(fit, p_bump.y + 10. * A, 0.30, 0.40);

pair p_mid_1 = FindVal(fit, p_dip.y + 0.5 * A, 0.50, 0.60);
pair p_mid_2 = FindVal(fit, p_dip.y + 0.5 * A, 0.70, 0.80);

pair p_dip_b = FindVal(fit, p_dip.y, 0.80, 0.90);

mark p = mCi + 2pt + red;
pen pd = black+dotted;
pen pa = black;

draw(Scale(p_dip), p); label(Label("dip"), Scale(p_dip), S, red);
draw(Scale(p_bump), p); label(Label("bump"), Scale(p_bump), N, red);

draw(Scale(p_bump_0), p); label(Label("bump2"), Scale(p_bump_0), NW+0.3W, red);
draw(Scale(p_bump_5), p); label(Label("bump+5"), Scale(p_bump_5), W, red);
draw(Scale(p_bump_10), p); label(Label("bump+10"), Scale(p_bump_10), NE, red);

draw(Scale(p_mid_1), p); label(Label("mid1"), Scale(p_mid_1), NW, red);
draw(Scale(p_mid_2), p); label(Label("mid2"), Scale(p_mid_2), NE, red);

draw(Scale(p_dip_b), p); label(Label("dip2"), Scale(p_dip_b), SW, red);

draw(Scale((0.33, p_dip.y))--Scale((0.94, p_dip_b.y)), pd);

draw(Scale((0.50, p_mid_1.y))--Scale((0.94, p_mid_2.y )), pd);

draw(Scale((0.33, p_bump_0.y))--Scale((0.94, p_bump.y )), pd);

draw(Scale(p_bump_5)--Scale((0.48, p_bump_5.y)), pd);

draw(Scale(p_bump_10)--Scale((0.53, p_bump_10.y)), pd);

real x = 0.35; draw(Label("$A$", 0.5, W), Scale((x, p_dip.y))--Scale((x, p_bump.y)), Arrows(5));

real x = 0.91; draw(Label("$A/2$", 0.5, E), Scale((x, p_dip.y))--Scale((x, p_mid_2.y)), Arrows(5));
real x = 0.91; draw(Label("$A/2$", 0.5, E), Scale((x, p_mid_2.y))--Scale((x, p_bump.y)), Arrows(5));

real x = 0.48; draw(Label("$5A$", 0.5, W), Scale((x, p_bump_0.y))--Scale((x, p_bump_5.y)), Arrows(5));

real x = 0.54; draw(Label("$10A$", 0.5, E), Scale((x, p_bump_0.y))--Scale((x, p_bump_10.y)), Arrows(5));

label(expLabel, (0.98, -0.5), W, Fill(white));

limits((0.2, 2e-2), (1.0, 0.4), Crop);
