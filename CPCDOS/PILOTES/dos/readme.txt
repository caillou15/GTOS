--------------------------------------------------------------------
	�����Ƃ͂��`�� DOS Driver
--------------------------------------------------------------------

�����ɂ���h���C�o�́A�����Ƃ͂��`���USB�C���^�t�F�[�X��DOS�Ŏg�p����ꍇ
�Ɏg���h���C�o�ł��BIEEE1394�C���^�t�F�[�X�̏ꍇ�́ADOS�ł̎g�p�͂ł��܂���B

DOS��Driver�Ƃ��Ĉȉ��̂R�̃h���C�o������܂��B

	USBASPI.SYS	: USB1.1���[�h��ASPI Manager�ł�
	RAMFD.SYS	: USB�|�[�g���P�����Ȃ��AUSB�t���b�s�[��
			�@�����������ꍇ�Ɏg�p����USB�t���b�s�[��
			�@RAM DISK���h���C�o�[�ł��B
	Di1000dd.SYS	: ASPI��HDD�h���C�o�[�ł��B

�P�DUSB�t���b�s�[���g���Ă��Ȃ��ꍇ
�������̋N���f�B�X�N��
USBASPI.SYS��Di1000dd.SYS�t�@�C�����R�s�[����config.sys�̖����ɉ��L�̂Q�s��
�ǉ����Ă��������B

device=USBASPI.SYS
device=Di1000dd.SYS

���̕ύX���s������ŁA�����Ƃ͂��`���USB�|�[�g�ɐڑ����A���̋N���f�B�X�N��FDD�ɃZ�b�g
���A���̋N���f�B�X�N����PC���N�����Ă��������B

�Q.USB�t���b�s�[���g���ꍇ
�������̋N���f�B�X�N��
USBASPI.SYS�ADi1000dd.SYS��RAMFD.SYS�t�@�C�����R�s�[����config.sys�̖�����
���L�̂R�s��ǉ����Ă��������B

device=RAMFD.SYS
device=USBASPI.SYS /W�@�@�@�@---�@������USB�|�[�g������AUSB�t���b�s�[�Ɩ{���i�𓯎���
�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@USB�|�[�g�ɐڑ��ł���ꍇ�́A/R�I�v�V�������g�p�ł��܂��B
device=Di1000dd.SYS

�܂��A
device=himem.sys
��config.sys�̒��ɋL�ڂ���Ă��邩�m�F���Ă��������B
���̋L�ڂ��Ȃ��ꍇ�́A���L�̂S�s��ǉ����Ă��������B

device=himem.sys
device=RAMFD.SYS
device=USBASPI.SYS /W
device=Di1000dd.SYS

����Ɏ��s����܂��ƁA�N���f�B�X�N�ŋN������r����FD�̓��e��RAM�f�B�X�N�ɃR�s�[��
�R�s�[����������ƁA���L�̃��b�Z�[�W���\������܂��B

===============================================
===  Connect the target device to USB port. ===
===  Press [ENTER} to continue.             ===
===============================================

���̃��b�Z�[�W���\������܂�����AUSB�t���b�s�[��USB�|�[�g���甲���āA�͂��`���
USB�|�[�g�ɐڑ����AENTER�L�[�������Ă��������B
������PC�̋N�������s���܂��B�i�������RAM�f�B�X�N����̋N���ɂȂ�܂��B�j


���ӁF
�P�jWindows���ċN����A������DOS���[�h�ɐ؂�ւ��Ďg�p���邱�Ƃ͂ł��܂���B�K��PC
�̓d����OFF���Ă���N�����Ă��������B
�Q�j���̑��̃I�v�V�����ݒ�ɂ���
USBASPI.SYS�ɂ́A���L�̃I�v�V�����ݒ肪����܂��B
	/R	: USB FDD�ƕ��p����ꍇ�Ɏw�肵�܂��B
		: �p�\�R���ɂ���Ă�RAMFD.SYS���K�v�ȏꍇ������܂��B

	/W	: USB�t���b�s�[���Y�t����Ă���@���USB�|�[�g��1�|�[�g�����Ȃ�
		  �@��Ńt���b�s�[����DOS(Windows)���N�����鎞�ɁA�t���b�s�[��
		  USB�f�o�C�X�����ւ���Ƃ��Ɏw�肵�܂��B
		  �ȉ��̃��b�Z�[�W��\�����Č����𑣂��܂��B
		 ===============================================
		 ===  Connect the target device to USB port. ===
�@�@�@�@�@�@�@�@ ===  Press [ENTER} to continue.             ===
		 ===============================================

	/M=xx	: OHCI�̃������}�b�v�A�h���X���w�肵�܂�
		  �f�t�H���Ƃ�D0000h����DFFFFFh���T�[�`���Ė��g�p�Ǝv����A�h���X
		  ���g�p���܂�
		  ��) /M=D4  : D4000h���g�p���܂�

	/P=xxx0	: UHCI��I/O�A�h���X���w�肵�܂�
		  �{��BIOS�ɂ����Controller��I/O Port Address���A�T�C�������
		  ���Ȃ��Ƃ��Ɏw�肵�܂�
	/V	: �e�����\�����܂�
�R�jOHCI�̏ꍇ�AEMM386.EXE�͋ɗ͎g�p���Ȃ��ŉ������B
�@�@�g�p����ꍇ��UMB���g�p���Ȃ��ݒ�ɂ��邩�AX=D000-DFFF���w�肵�Ċg��ROM��Ԃ������ĉ������B
�S�jUHCI��I/O�|�[�g���{��BIOS�ɂ���Đݒ肳��Ă��Ȃ��@�킪����܂��B
�@�@���̂悤�ȋ@��ł�/P�I�v�V�����ɂ��I/O�|�[�g���w�肷��K�v������܂��B

�⑫�FOHCI��UHCI�ɂ���
USB�̃z�X�g�R���g���[���`�b�v�̋K�i�ɂ́A���L�̂Q��ނ�����܂��B
Universal Host Controller Interface ��UHCI
Open Host Controller Interface ��OHCI
����2��ނ̏ڂ��������͂����ł́A�ȗ����܂����A���q�l�����g����PC���ǂ���̋K�i�Ȃ̂���
���L�̕��@�Ŋm�F�ł��܂��B
�P�D[�X�^�[�g] -> [�ݒ�(S)] -> [�R���g���[�� �p�l��(C)] ���N���b�N���܂��B 
�Q�D[�V�X�e��] �A�C�R�����_�u���N���b�N���܂��B 
�R�D[�f�o�C�X �}�l�[�W��] �^�u���N���b�N���܂��B 
�S�D[���j�o�[�T�� �V���A�� �o�X �R���g���[��] ���_�u���N���b�N���܂��B 

************* Universal Host Controller 
�ƕ\������Ă���ꍇ�AUHCI ���g�p���Ă��܂��B 

************* Open Host Controller 
�ƕ\������Ă���ꍇ�AOHCI ���g�p���Ă��܂��B 



