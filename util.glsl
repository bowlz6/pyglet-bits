float exp_blender(float f)
{
	return pow(2.71828182846, f);
}

vec4 rgb_to_hsv(vec4 rgb, out vec4 outcol)
{
	float cmax, cmin, h, s, v, cdelta;
	vec3 c;

	cmax = max(rgb[0], max(rgb[1], rgb[2]));
	cmin = min(rgb[0], min(rgb[1], rgb[2]));
	cdelta = cmax-cmin;

	v = cmax;
	if (cmax!=0.0)
		s = cdelta/cmax;
	else {
		s = 0.0;
		h = 0.0;
	}

	if (s == 0.0) {
		h = 0.0;
	}
	else {
		c = (vec3(cmax, cmax, cmax) - rgb.xyz)/cdelta;

		if (rgb.x==cmax) h = c[2] - c[1];
		else if (rgb.y==cmax) h = 2.0 + c[0] -  c[2];
		else h = 4.0 + c[1] - c[0];

		h /= 6.0;

		if (h<0.0)
			h += 1.0;
	}

	return vec4(h, s, v, rgb.w);
}

vec4 hsv_to_rgb(vec4 hsv)
{
	float i, f, p, q, t, h, s, v;
	vec3 rgb;

	h = hsv[0];
	s = hsv[1];
	v = hsv[2];

	if(s==0.0) {
		rgb = vec3(v, v, v);
	}
	else {
		if(h==1.0)
			h = 0.0;
		
		h *= 6.0;
		i = floor(h);
		f = h - i;
		rgb = vec3(f, f, f);
		p = v*(1.0-s);
		q = v*(1.0-(s*f));
		t = v*(1.0-(s*(1.0-f)));
		
		if (i == 0.0) rgb = vec3(v, t, p);
		else if (i == 1.0) rgb = vec3(q, v, p);
		else if (i == 2.0) rgb = vec3(p, v, t);
		else if (i == 3.0) rgb = vec3(p, q, v);
		else if (i == 4.0) rgb = vec3(t, p, v);
		else rgb = vec3(v, p, q);
	}
	return vec4(rgb, hsv.w);
}

float srgb_to_linearrgb(float c)
{
	if(c < 0.04045)
		return (c < 0.0)? 0.0: c * (1.0/12.92);
	else
		return pow((c + 0.055)*(1.0/1.055), 2.4);
}

float linearrgb_to_srgb(float c)
{
	if(c < 0.0031308)
		return (c < 0.0)? 0.0: c * 12.92;
	else
		return 1.055 * pow(c, 1.0/2.4) - 0.055;
}

vec4 srgb_to_linearrgb(vec4 col_from)
{
	vec4 col_to;
	col_to.r = srgb_to_linearrgb(col_from.r);
	col_to.g = srgb_to_linearrgb(col_from.g);
	col_to.b = srgb_to_linearrgb(col_from.b);
	col_to.a = col_from.a;
	return col_to;
}

vec4 linearrgb_to_srgb(vec4 col_from)
{
	vec4 col_to;
	col_to.r = linearrgb_to_srgb(col_from.r);
	col_to.g = linearrgb_to_srgb(col_from.g);
	col_to.b = linearrgb_to_srgb(col_from.b);
	col_to.a = col_from.a;
	return col_to;
}

#define M_PI 3.14159265358979323846
#define M_1_PI 0.31830988618379069
