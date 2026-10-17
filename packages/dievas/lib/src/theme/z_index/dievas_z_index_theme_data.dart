import 'package:dievas_tokens/dievas_tokens.dart';
import 'package:equatable/equatable.dart';

/// Stacking-order tokens for consumers that explicitly sort overlay layers.
/// Flutter painting order still follows widget and OverlayEntry insertion order;
/// these values do not change stacking automatically.
final class DievasZIndexThemeData extends Equatable {
  const DievasZIndexThemeData({
    this.dropdown = DievasZIndexSemantic.dropdown,
    this.sticky = DievasZIndexSemantic.sticky,
    this.fixedHeader = DievasZIndexSemantic.fixedHeader,
    this.modalBackdrop = DievasZIndexSemantic.modalBackdrop,
    this.modal = DievasZIndexSemantic.modal,
    this.popover = DievasZIndexSemantic.popover,
    this.tooltip = DievasZIndexSemantic.tooltip,
    this.toast = DievasZIndexSemantic.toast,
    this.loader = DievasZIndexSemantic.loader,
  });

  final int dropdown;
  final int sticky;
  final int fixedHeader;
  final int modalBackdrop;
  final int modal;
  final int popover;
  final int tooltip;
  final int toast;
  final int loader;

  DievasZIndexThemeData copyWith({
    int? dropdown,
    int? sticky,
    int? fixedHeader,
    int? modalBackdrop,
    int? modal,
    int? popover,
    int? tooltip,
    int? toast,
    int? loader,
  }) => DievasZIndexThemeData(
    dropdown: dropdown ?? this.dropdown,
    sticky: sticky ?? this.sticky,
    fixedHeader: fixedHeader ?? this.fixedHeader,
    modalBackdrop: modalBackdrop ?? this.modalBackdrop,
    modal: modal ?? this.modal,
    popover: popover ?? this.popover,
    tooltip: tooltip ?? this.tooltip,
    toast: toast ?? this.toast,
    loader: loader ?? this.loader,
  );

  @override
  List<Object?> get props => [dropdown, sticky, fixedHeader, modalBackdrop, modal, popover, tooltip, toast, loader];
}
