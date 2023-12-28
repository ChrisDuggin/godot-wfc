const blocks = {

    'INS': {
		'resource': 'res://blocks/INS.tscn',
		'paths': {
			'n': true,
			'e': false,
			's': true,
			'w': false,
		},
	},		
    'IEW': {
		'resource': 'res://blocks/IEW.tscn',
		'paths': {
			'n': false,
			'e': true,
			's': false,
			'w': true,
		},
	},		


	'LES': {
		'resource': 'res://blocks/LES.tscn',
		'paths': {
			'n': false,
			'e': true,
			's': true,
			'w': false,
		},
	},		
	'LNE': {
		'resource': 'res://blocks/LNE.tscn',
		'paths': {
			'n': true,
			'e': true,
			's': false,
			'w': false,
		},
	},	
	'LNW': {
		'resource': 'res://blocks/LNW.tscn',
		'paths': {
			'n': true,
			'e': false,
			's': false,
			'w': true,
		},
	},	
	'LSW': {
		'resource': 'res://blocks/LSW.tscn',
		'paths': {
			'n': false,
			'e': false,
			's': true,
			'w': true,
		},
	},			
    'O': {
		'resource': 'res://blocks/O.tscn',
		'paths': {
			'n': true,
			'e': true,
			's': true,
			'w': true,
		},
	},	
    'PES': {
		'resource': 'res://blocks/PES.tscn',
		'paths': {
			'n': false,
			'e': true,
			's': true,
			'w': false,
		},
	},		
	'PNE': {
		'resource': 'res://blocks/PNE.tscn',
		'paths': {
			'n': true,
			'e': true,
			's': false,
			'w': false,
		},
	},	
	'PNW': {
		'resource': 'res://blocks/PNW.tscn',
		'paths': {
			'n': true,
			'e': false,
			's': false,
			'w': true,
		},
	},	
	'PSW': {
		'resource': 'res://blocks/PSW.tscn',
		'paths': {
			'n': false,
			'e': false,
			's': true,
			'w': true,
		},
	},		
    'TESW': {
		'resource': 'res://blocks/TESW.tscn',
		'paths': {
			'n': false,
			'e': true,
			's': true,
			'w': true,
		},
	},	
    'TNES': {
		'resource': 'res://blocks/TNES.tscn',
		'paths': {
			'n': true,
			'e': true,
			's': true,
			'w': false,
		},
	},	
    'TNEW': {
		'resource': 'res://blocks/TNEW.tscn',
		'paths': {
			'n': true,
			'e': true,
			's': false,
			'w': true,
		},
	},	
    'TNSW': {
		'resource': 'res://blocks/TNSW.tscn',
		'paths': {
			'n': true,
			'e': false,
			's': true,
			'w': true,
		},
	},	

    'WESW': {
		'resource': 'res://blocks/WESW.tscn',
		'paths': {
			'n': false,
			'e': true,
			's': true,
			'w': true,
		},
	},	
    'WNES': {
		'resource': 'res://blocks/WNES.tscn',
		'paths': {
			'n': true,
			'e': true,
			's': true,
			'w': false,
		},
	},	
    'WNEW': {
		'resource': 'res://blocks/WNEW.tscn',
		'paths': {
			'n': true,
			'e': true,
			's': false,
			'w': true,
		},
	},	
    'WNSW': {
		'resource': 'res://blocks/WNSW.tscn',
		'paths': {
			'n': true,
			'e': false,
			's': true,
			'w': true,
		},
	},	
    'X': {
		'resource': 'res://blocks/X.tscn',
		'paths': {
			'n': true,
			'e': true,
			's': true,
			'w': true,
		},
	},	
}

Object.keys(blocks).forEach((val)=>{
	blockRef = blocks[val]
    Object.keys(blocks).forEach((block)=>{
        if(val == block) return
        if(!blocks[val].neighbors) blocks[val]['neighbors'] = {n:[], e:[], s:[], w:[]}
        
        if(blockRef.paths.n && blocks[block].paths.s) {
            blocks[val].neighbors?.n?.push(block)
        }

        if(blockRef.paths.e && blocks[block].paths.w) {
            blocks[val].neighbors?.e?.push(block)
        }

        if(blockRef.paths.s && blocks[block].paths.n) {
            blocks[val].neighbors?.s?.push(block)
        }

        if(blockRef.paths.w && blocks[block].paths.e) {
            blocks[val].neighbors?.w?.push(block)
        }
        
    })
    
})

console.log(JSON.stringify(blocks, undefined, 4))