{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : 		{
			"major" : 9,
			"minor" : 0,
			"revision" : 0,
			"architecture" : "x64",
			"modernui" : 1
		}
,
		"classnamespace" : "box",
		"rect" : [ 59.0, 119.0, 640.0, 480.0 ],
		"bglocked" : 0,
		"openinpresentation" : 0,
		"default_fontsize" : 12.0,
		"default_fontface" : 0,
		"default_fontname" : "Arial",
		"gridonopen" : 1,
		"gridsize" : [ 15.0, 15.0 ],
		"gridsnaponopen" : 1,
		"objectsnaponopen" : 1,
		"statusbarvisible" : 2,
		"toolbarvisible" : 1,
		"lefttoolbarpinned" : 0,
		"toptoolbarpinned" : 0,
		"righttoolbarpinned" : 0,
		"bottomtoolbarpinned" : 0,
		"toolbars_unpinned_last_save" : 0,
		"tallnewobj" : 0,
		"boxanimatetime" : 200,
		"enablehscroll" : 1,
		"enablevscroll" : 1,
		"devicewidth" : 0.0,
		"description" : "Spectral Blur - AI-inspired frequency smearing",
		"digest" : "",
		"tags" : "",
		"style" : "",
		"subpatcher_template" : "",
		"assistshowspatchername" : 0,
		"boxes" : [ 			{
				"box" : 				{
					"id" : "obj-comment1",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 50.0, 40.0, 400.0, 20.0 ],
					"text" : "Spectral Blur - Smears frequency bins to simulate neural encoding"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-in1",
					"maxclass" : "inlet",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 50.0, 80.0, 30.0, 30.0 ],
					"comment" : "Real (from fftin~)"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-in2",
					"maxclass" : "inlet",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 100.0, 80.0, 30.0, 30.0 ],
					"comment" : "Imaginary (from fftin~)"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-in3",
					"maxclass" : "inlet",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 400.0, 80.0, 30.0, 30.0 ],
					"comment" : "Blur amount (0-1)"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-cartopol1",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "signal", "signal" ],
					"patching_rect" : [ 50.0, 140.0, 100.0, 22.0 ],
					"text" : "cartopol~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-avg-mag",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 50.0, 180.0, 150.0, 22.0 ],
					"text" : "slide~ 100 100"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-blur-mult",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 400.0, 140.0, 50.0, 22.0 ],
					"text" : "*~ 0.5"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-xfade",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 50.0, 220.0, 100.0, 22.0 ],
					"text" : "selector~ 2 1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-phase-rand",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 150.0, 180.0, 100.0, 22.0 ],
					"text" : "rand~ 0.1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-phase-mod",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 150.0, 220.0, 40.0, 22.0 ],
					"text" : "+~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-poltocar",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "signal", "signal" ],
					"patching_rect" : [ 50.0, 280.0, 100.0, 22.0 ],
					"text" : "poltocar~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-out1",
					"maxclass" : "outlet",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 50.0, 340.0, 30.0, 30.0 ],
					"comment" : "Real (to fftout~)"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-out2",
					"maxclass" : "outlet",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 150.0, 340.0, 30.0, 30.0 ],
					"comment" : "Imaginary (to fftout~)"
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-in1", 0 ],
					"destination" : [ "obj-cartopol1", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-in2", 0 ],
					"destination" : [ "obj-cartopol1", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-cartopol1", 0 ],
					"destination" : [ "obj-avg-mag", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-cartopol1", 1 ],
					"destination" : [ "obj-phase-rand", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-cartopol1", 1 ],
					"destination" : [ "obj-phase-mod", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-phase-rand", 0 ],
					"destination" : [ "obj-phase-mod", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-avg-mag", 0 ],
					"destination" : [ "obj-xfade", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-cartopol1", 0 ],
					"destination" : [ "obj-xfade", 2 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-in3", 0 ],
					"destination" : [ "obj-blur-mult", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-blur-mult", 0 ],
					"destination" : [ "obj-xfade", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-xfade", 0 ],
					"destination" : [ "obj-poltocar", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-phase-mod", 0 ],
					"destination" : [ "obj-poltocar", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-poltocar", 0 ],
					"destination" : [ "obj-out1", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-poltocar", 1 ],
					"destination" : [ "obj-out2", 0 ]
				}

			}
 ]
	}

}
